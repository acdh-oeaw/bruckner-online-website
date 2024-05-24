/* eslint-disable @typescript-eslint/no-unsafe-assignment */

import type { MDXComponents } from "mdx/types";

import Download from "@/components/content/download.astro";
import Embed from "@/components/content/embed.astro";
import Figure from "@/components/content/figure.astro";
import Img from "@/components/content/img.astro";
import TranskriptionsTool from "@/components/content/transkriptions-tool.astro";
import Video from "@/components/content/video.astro";

export function useMDXComponents(): MDXComponents {
	return {
		Download,
		Embed,
		Figure,
		// eslint-disable-next-line @typescript-eslint/no-explicit-any
		img: Img as any,
		TranskriptionsTool,
		Video,
	};
}
