/* @jsxImportSource react */

import {
	createAssetOptions,
	createCollection,
	createContentFieldOptions,
	createLabel,
} from "@acdh-oeaw/keystatic-lib";
import { collection, fields } from "@keystatic/core";

import {
	createAudioPlayer,
	createEmbed,
	createFigure,
	createFootnote,
	createHeadingId,
	createLink,
	createTranskriptionsTool,
	createVideo,
} from "@/lib/keystatic/components";

export const createPages = createCollection("/pages/", (paths, locale) => {
	return collection({
		label: createLabel("Pages", locale),
		path: paths.contentPath,
		format: { contentField: "content" },
		slugField: "title",
		columns: ["title"],
		entryLayout: "content",
		schema: {
			title: fields.slug({
				name: {
					label: "Title",
					validation: { isRequired: true },
				},
			}),
			image: fields.image({
				label: "Image",
				validation: { isRequired: true },
				...createAssetOptions(paths.assetPath),
			}),
			summary: fields.text({
				label: "Summary",
				validation: { isRequired: true },
				multiline: true,
			}),
			content: fields.mdx({
				label: "Content",
				options: createContentFieldOptions(paths.assetPath),
				components: {
					...createAudioPlayer(paths.assetPath, locale),
					...createEmbed(paths.assetPath, locale),
					...createFigure(paths.assetPath, locale),
					...createFootnote(paths.assetPath, locale),
					...createHeadingId(paths.assetPath, locale),
					...createLink(paths.assetPath, locale),
					...createTranskriptionsTool(paths.assetPath, locale),
					...createVideo(paths.assetPath, locale),
				},
			}),
		},
	});
});
