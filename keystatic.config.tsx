import { collection, config, fields, singleton } from "@keystatic/core";

import { Logo } from "@/components/logo";
import { createAssetPaths, createPreviewUrl } from "@/config/content.config";
import { env } from "@/config/env.config";
import { createComponents } from "@/lib/content/create-components";

export default config({
	ui: {
		brand: {
			name: "Bruckner Online",
			// @ts-expect-error `ReactNode` is a valid return type.
			mark: Logo,
		},
		navigation: {
			Pages: ["indexPage", "pages"],
			Navigation: ["navigation"],
			Settings: ["metadata"],
		},
	},
	storage:
		/**
		 * @see https://keystatic.com/docs/github-mode
		 */
		env.PUBLIC_KEYSTATIC_MODE === "github" &&
		env.PUBLIC_KEYSTATIC_GITHUB_REPO_OWNER &&
		env.PUBLIC_KEYSTATIC_GITHUB_REPO_NAME
			? {
					kind: "github",
					repo: {
						owner: env.PUBLIC_KEYSTATIC_GITHUB_REPO_OWNER,
						name: env.PUBLIC_KEYSTATIC_GITHUB_REPO_NAME,
					},
					branchPrefix: "content/",
				}
			: {
					kind: "local",
				},
	collections: {
		pages: collection({
			label: "Pages",
			path: "./content/pages/**",
			slugField: "title",
			format: { contentField: "content" },
			previewUrl: createPreviewUrl("/{slug}"),
			entryLayout: "content",
			columns: ["title"],
			schema: {
				title: fields.slug({
					name: {
						label: "Title",
						validation: { isRequired: true },
					},
				}),
				image: fields.image({
					label: "Image",
					...createAssetPaths("/content/pages/"),
					// validation: { isRequired: false },
				}),
				summary: fields.text({
					label: "Summary",
					multiline: true,
					// validation: { isRequired: true },
				}),
				"tables-striped": fields.checkbox({
					label: "Striped Table Layout",
					description:
						"Activate if tables on this page should have different background colors for even and odd rows.",
				}),
				vita: fields.array(
					fields.object({
						period: fields.text({ label: "Period" }),
						description: fields.mdx.inline({ label: "Description" }),
					}),
					{
						label: "Vita entries",
						itemLabel: (props) => {
							return props.fields.period.value;
						},
					},
				),
				content: fields.mdx({
					label: "Content",
					options: {
						image: createAssetPaths("/content/pages/"),
					},
					components: createComponents("/content/pages/"),
				}),
			},
		}),
	},
	singletons: {
		indexPage: singleton({
			label: "Home page",
			path: "./content/index-page/",
			format: { data: "json" },
			entryLayout: "form",
			schema: {
				hero: fields.object(
					{
						slides: fields.array(
							fields.object(
								{
									title: fields.text({
										label: "Title",
										validation: { isRequired: true },
									}),
									summary: fields.text({
										label: "Summary",
										validation: { isRequired: true },
									}),
									alignment: fields.select({
										label: "Summary alignment",
										options: [
											{ label: "Left", value: "left" },
											{ label: "Right", value: "right" },
										],
										defaultValue: "left",
									}),
									image: fields.image({
										label: "Image",
										...createAssetPaths("/content/index-page/"),
										validation: { isRequired: true },
									}),
									page: fields.relationship({
										label: "Page",
										collection: "pages",
										validation: { isRequired: true },
									}),
								},
								{
									label: "Slide",
								},
							),
							{
								label: "Slides",
								itemLabel(props) {
									return props.fields.title.value;
								},
								validation: { length: { min: 1 } },
							},
						),
					},
					{
						label: "Hero section",
					},
				),
				quote: fields.text({
					label: "Quote",
					validation: { isRequired: true },
				}),
				links: fields.array(
					fields.object(
						{
							title: fields.text({
								label: "Title",
								validation: { isRequired: true },
							}),
							summary: fields.text({
								label: "Summary",
								validation: { isRequired: true },
							}),
							page: fields.relationship({
								label: "Page",
								collection: "pages",
								validation: { isRequired: true },
							}),
						},
						{
							label: "Link",
						},
					),
					{
						label: "Links",
						itemLabel(props) {
							return props.fields.title.value;
						},
						validation: { length: { min: 1 } },
					},
				),
			},
		}),
		metadata: singleton({
			label: "Metadata",
			path: "./content/metadata",
			format: { data: "json" },
			entryLayout: "form",
			schema: {
				title: fields.text({
					label: "Site title",
					validation: { isRequired: true },
				}),
				shortTitle: fields.text({
					label: "Short site title",
					validation: { isRequired: true },
				}),
				description: fields.text({
					label: "Site description",
					validation: { isRequired: true },
				}),
				twitter: fields.text({
					label: "Twitter handle",
					// validation: { isRequired: false },
				}),
			},
		}),
		navigation: singleton({
			label: "Navigation",
			path: "./content/navigation",
			format: { data: "json" },
			entryLayout: "form",
			schema: {
				links: fields.blocks(
					{
						link: {
							label: "Link",
							itemLabel(props) {
								return props.fields.label.value;
							},
							schema: fields.object({
								label: fields.text({
									label: "Label",
									validation: { isRequired: true },
								}),
								href: fields.url({
									label: "URL",
									validation: { isRequired: true },
								}),
							}),
						},
						page: {
							label: "Page",
							itemLabel(props) {
								return props.fields.label.value;
							},
							schema: fields.object({
								label: fields.text({
									label: "Label",
									validation: { isRequired: true },
								}),
								reference: fields.relationship({
									label: "Page",
									collection: "pages",
									validation: { isRequired: true },
								}),
							}),
						},
						menu: {
							label: "Menu",
							itemLabel(props) {
								return `${props.fields.label.value} (Menu)`;
							},
							schema: fields.object({
								label: fields.text({
									label: "Label",
									validation: { isRequired: true },
								}),
								links: fields.blocks(
									{
										link: {
											label: "Link",
											itemLabel(props) {
												return props.fields.label.value;
											},
											schema: fields.object(
												{
													label: fields.text({
														label: "Label",
														validation: { isRequired: true },
													}),
													href: fields.url({
														label: "URL",
														validation: { isRequired: true },
													}),
												},
												{
													label: "Link",
												},
											),
										},
										page: {
											label: "Page",
											itemLabel(props) {
												return props.fields.label.value;
											},
											schema: fields.object(
												{
													label: fields.text({
														label: "Label",
														validation: { isRequired: true },
													}),
													reference: fields.relationship({
														label: "Page",
														collection: "pages",
														validation: { isRequired: true },
													}),
												},
												{
													label: "Page",
												},
											),
										},
										separator: {
											label: "Separator",
											schema: fields.empty(),
										},
										section: {
											label: "Section",
											itemLabel(props) {
												return props.fields.label.value;
											},
											schema: fields.object({
												label: fields.text({
													label: "Section Title",
													validation: { isRequired: true },
												}),
												links: fields.blocks(
													{
														link: {
															label: "Link",
															itemLabel(props) {
																return props.fields.label.value;
															},
															schema: fields.object(
																{
																	label: fields.text({
																		label: "Label",
																		validation: { isRequired: true },
																	}),
																	href: fields.url({
																		label: "URL",
																		validation: { isRequired: true },
																	}),
																},
																{
																	label: "Link",
																},
															),
														},
														page: {
															label: "Page",
															itemLabel(props) {
																return props.fields.label.value;
															},
															schema: fields.object(
																{
																	label: fields.text({
																		label: "Label",
																		validation: { isRequired: true },
																	}),
																	reference: fields.relationship({
																		label: "Page",
																		collection: "pages",
																		validation: { isRequired: true },
																	}),
																},
																{
																	label: "Page",
																},
															),
														},
														separator: {
															label: "Separator",
															schema: fields.empty(),
														},
													},
													{
														label: "Links",
														validation: { length: { min: 1 } },
													},
												),
											}),
										},
									},
									{
										label: "Links",
										validation: { length: { min: 1 } },
									},
								),
							}),
						},
					},
					{
						label: "Links",
						validation: { length: { min: 1 } },
					},
				),
			},
		}),
	},
});
