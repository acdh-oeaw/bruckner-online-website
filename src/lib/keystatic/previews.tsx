/* @jsxImportSource react */

import { useObjectUrl, type UseObjectUrlParams } from "@acdh-oeaw/keystatic-lib/preview";
import { cn } from "@acdh-oeaw/style-variants";
import { NotEditable } from "@keystatic/core";
import type { ReactNode } from "react";

import type { VideoProvider } from "@/lib/keystatic/component-options";
import { createVideoUrl } from "@/lib/keystatic/create-video-url";

interface AudioPlayerPreviewProps {
	tracks: ReadonlyArray<{
		title: string;
	}>;
}

export function AudioPlayerPreview(props: AudioPlayerPreviewProps): ReactNode {
	const { tracks } = props;

	return (
		<NotEditable>
			<ul>
				{tracks.map((track, index) => {
					return (
						<li key={index}>
							<div>{track.title}</div>
						</li>
					);
				})}
			</ul>
		</NotEditable>
	);
}

interface EmbedPreviewProps {
	children?: ReactNode;
	src: string | null;
}

export function EmbedPreview(props: EmbedPreviewProps): ReactNode {
	const { children, src } = props;

	if (src == null) return null;

	return (
		<figure className="grid gap-y-2">
			<NotEditable>
				{/* eslint-disable-next-line jsx-a11y/iframe-has-title */}
				<iframe
					allowFullScreen={true}
					className="aspect-video w-full overflow-hidden rounded-1"
					src={src}
				/>
			</NotEditable>
			<figcaption>{children}</figcaption>
		</figure>
	);
}

interface FigurePreviewProps {
	/** @default "stretch" */
	alignment?: "center" | "stretch";
	alt?: string;
	children?: ReactNode;
	src: UseObjectUrlParams | null;
}

export function FigurePreview(props: FigurePreviewProps): ReactNode {
	const { alignment = "stretch", alt = "", children, src } = props;

	const url = useObjectUrl(src);

	if (url == null) return null;

	return (
		<figure className={cn("grid gap-y-2", alignment === "center" ? "justify-center" : undefined)}>
			<NotEditable>
				<img alt={alt} className="overflow-hidden rounded-1" src={url} />
			</NotEditable>
			<figcaption>{children}</figcaption>
		</figure>
	);
}

interface HeadingIdPreviewProps {
	children: ReactNode;
}

export function HeadingIdPreview(props: HeadingIdPreviewProps): ReactNode {
	const { children } = props;

	return (
		<NotEditable>
			<span className="opacity-50">#{children}</span>
		</NotEditable>
	);
}

interface VideoPreviewProps {
	children?: ReactNode;
	id: string;
	provider: VideoProvider;
	startTime?: number | null;
}

export function VideoPreview(props: VideoPreviewProps): ReactNode {
	const { children, id, provider, startTime } = props;

	const href = String(createVideoUrl(provider, id, startTime));

	return (
		<figure>
			<NotEditable className="grid gap-y-2">
				{/* eslint-disable-next-line jsx-a11y/iframe-has-title */}
				<iframe
					allowFullScreen={true}
					className="aspect-video w-full overflow-hidden rounded-1"
					src={href}
				/>
			</NotEditable>
			<figcaption>{children}</figcaption>
		</figure>
	);
}
