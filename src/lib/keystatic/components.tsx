/* @jsxImportSource react */

import { createAssetOptions, createComponent } from "@acdh-oeaw/keystatic-lib";
import { fields } from "@keystatic/core";
import { block, inline, mark, wrapper } from "@keystatic/core/content-components";
import {
	AppWindowIcon,
	HashIcon,
	ImageIcon,
	LinkIcon,
	PencilIcon,
	PlayIcon,
	SuperscriptIcon,
	VideoIcon,
} from "lucide-react";

import { figureAlignments, videoProviders } from "@/lib/keystatic/component-options";
import { createLinkSchema } from "@/lib/keystatic/create-link-schema";
import {
	AudioPlayerPreview,
	EmbedPreview,
	FigurePreview,
	HeadingIdPreview,
	VideoPreview,
} from "@/lib/keystatic/previews";

export const createAudioPlayer = createComponent((assetPath, _locale) => {
	return {
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
								...createAssetOptions(assetPath),
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
				const { value } = props;

				return <AudioPlayerPreview tracks={value.tracks} />;
			},
		}),
	};
});

export const createEmbed = createComponent((_assetPath, _locale) => {
	return {
		Embed: wrapper({
			label: "Embed",
			icon: <AppWindowIcon />,
			schema: {
				src: fields.url({
					label: "URL",
					validation: { isRequired: true },
				}),
			},
			ContentView(props) {
				const { children, value } = props;

				return <EmbedPreview src={value.src}>{children}</EmbedPreview>;
			},
		}),
	};
});

export const createFigure = createComponent((assetPath, _locale) => {
	return {
		Figure: wrapper({
			label: "Figure",
			icon: <ImageIcon />,
			schema: {
				src: fields.image({
					label: "Image",
					validation: { isRequired: true },
					...createAssetOptions(assetPath),
				}),
				alt: fields.text({
					label: "Image description for assistive technology",
					validation: { isRequired: false },
				}),
				alignment: fields.select({
					label: "Alignment",
					options: figureAlignments,
					defaultValue: "stretch",
				}),
			},
			ContentView(props) {
				const { children, value } = props;

				return (
					<FigurePreview alignment={value.alignment} alt={value.alt} src={value.src}>
						{children}
					</FigurePreview>
				);
			},
		}),
	};
});

export const createFootnote = createComponent((_assetPath, _locale) => {
	return {
		Footnote: mark({
			label: "Footnote",
			icon: <SuperscriptIcon />,
			schema: {},
			className: "underline decoration-dotted align-super text-sm",
		}),
	};
});

export const createHeadingId = createComponent((_assetPath, _locale) => {
	return {
		HeadingId: inline({
			label: "HeadingId",
			icon: <HashIcon />,
			schema: {
				id: fields.text({
					label: "ID",
					validation: { isRequired: true },
				}),
			},
			ContentView(props) {
				const { value } = props;

				return <HeadingIdPreview>{value.id}</HeadingIdPreview>;
			},
		}),
	};
});

export const createLink = createComponent((assetPath, locale) => {
	return {
		Link: mark({
			label: "Link",
			icon: <LinkIcon />,
			schema: {
				link: createLinkSchema(assetPath, locale),
			},
			tag: "a",
		}),
	};
});

export const createTranskriptionsTool = createComponent(() => {
	return {
		TranskriptionsTool: block({
			label: "TranskriptionsTool",
			description: "A Transkribus embed.",
			icon: <PencilIcon />,
			schema: {},
		}),
	};
});

export const createVideo = createComponent((_assetPath, _locale) => {
	return {
		Video: wrapper({
			label: "Video",
			icon: <VideoIcon />,
			schema: {
				provider: fields.select({
					label: "Provider",
					options: videoProviders,
					defaultValue: "youtube",
				}),
				id: fields.text({
					label: "ID",
					validation: { isRequired: true },
				}),
				startTime: fields.number({
					label: "Start time",
					validation: { isRequired: false },
				}),
			},
			ContentView(props) {
				const { children, value } = props;

				return (
					<VideoPreview id={value.id} provider={value.provider} startTime={value.startTime}>
						{children}
					</VideoPreview>
				);
			},
		}),
	};
});
