/* eslint-disable @typescript-eslint/no-unsafe-assignment */

import AudioPlayer from "@/components/content/audio-player.astro";
import Embed from "@/components/content/embed.astro";
import Figure from "@/components/content/figure.astro";
import Img from "@/components/content/img.astro";
import Link from "@/components/content/link.astro";
import TranskriptionsTool from "@/components/content/transkriptions-tool.astro";
import Video from "@/components/content/video.astro";
import Anchor from "@/components/link.astro";

const components = {
	a: Anchor,
	AudioPlayer,
	Embed,
	Figure,
	img: Img,
	Link,
	TranskriptionsTool,
	Video,
};

declare global {
	type MDXProvidedComponents = typeof components;
}

export function useMDXComponents(): MDXProvidedComponents {
	return components;
}
