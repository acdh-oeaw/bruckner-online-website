import { createUrl, pick } from "@acdh-oeaw/lib";
import { collection, config, fields, NotEditable, singleton } from "@keystatic/core";
import { block, mark, wrapper } from "@keystatic/core/content-components";
import { DownloadIcon, ImageIcon, PencilIcon, PlayIcon, ScanIcon, VideoIcon } from "lucide-react";

import { Logo } from "@/components/logo";
import { createAssetPaths, createPreviewUrl } from "@/config/content.config";
import { env } from "@/config/env.config";

function createComponents(
	assetPath: `/${string}/`,
	components?: Array<"Download" | "Figure" | "Video">,
) {
	const allComponents = {
		AudioPlayer: block({
			label: "AudioPlayer",
			description: "An audio player with playlist.",
			icon: <PlayIcon />,
			schema: {
				tracks: fields.array(
					fields.object(
						{
							title: fields.text({
								label: "Title",
								validation: { isRequired: true },
							}),
							file: fields.file({
								label: "File",
								...createAssetPaths(assetPath),
								validation: { isRequired: true },
							}),
						},
						{
							label: "Track",
						},
					),
					{
						label: "Tracks",
						itemLabel(props) {
							return props.fields.title.value;
						},
					},
				),
			},
			ContentView(props) {
				return (
					<NotEditable>
						<ul>
							{props.value.tracks.map((track, index) => {
								return (
									<li key={index}>
										<div>{track.title}</div>
									</li>
								);
							})}
						</ul>
					</NotEditable>
				);
			},
		}),
		Download: mark({
			label: "Download",
			// description: "A link to an uploaded file.",
			tag: "a",
			className: "underline decoration-dotted",
			icon: <DownloadIcon />,
			schema: {
				href: fields.file({
					label: "File",
					...createAssetPaths(assetPath),
					validation: { isRequired: true },
				}),
			},
		}),
		Embed: wrapper({
			label: "Embed",
			description: "Another website embedded via iframe",
			icon: <ScanIcon />,
			schema: {
				href: fields.image({
					label: "Image",
					...createAssetPaths(assetPath),
					validation: { isRequired: true },
				}),
				caption: fields.text({
					label: "Caption",
					// validation: { isRequired: false },
				}),
			},
		}),
		Figure: wrapper({
			label: "Figure",
			description: "An image with caption.",
			icon: <ImageIcon />,
			schema: {
				href: fields.image({
					label: "Image",
					...createAssetPaths(assetPath),
					validation: { isRequired: true },
				}),
				alt: fields.text({
					label: "Image description for screen readers",
					// validation: { isRequired: false },
				}),
			},
		}),
		TranskriptionsTool: block({
			label: "TranskriptionsTool",
			description: "A Transkribus embed.",
			icon: <PencilIcon />,
			schema: {},
		}),
		Video: block({
			label: "Video",
			description: "An embedded video.",
			icon: <VideoIcon />,
			schema: {
				provider: fields.select({
					label: "Video provider",
					options: [
						{
							label: "YouTube",
							value: "youtube",
						},
					],
					defaultValue: "youtube",
				}),
				id: fields.text({
					label: "Video ID",
					validation: { isRequired: true },
				}),
				caption: fields.text({
					label: "Caption",
					// validation: { isRequired: false },
				}),
			},
			ContentView(props) {
				const { caption, id } = props.value;

				const href = String(
					createUrl({
						baseUrl: "https://www.youtube-nocookie.com",
						pathname: `/embed/${id}`,
					}),
				);

				return (
					<NotEditable>
						<figure>
							<iframe allowFullScreen={true} src={href} title="Video" />
							{caption ? <figcaption>{caption}</figcaption> : null}
						</figure>
					</NotEditable>
				);
			},
		}),
	};

	if (components == null) return allComponents;

	return pick(allComponents, components);
}

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
								return props.fields.label.value + " (Menu)";
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
