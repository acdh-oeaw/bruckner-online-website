import { createPreset } from "@acdh-oeaw/tailwindcss-preset";
import type { Config } from "tailwindcss";
import colors from "tailwindcss/colors";

const preset = createPreset();

const brandColors: Record<string, string> = {
	red: "var(--color-brand-red)",
	orange: "var(--color-brand-orange)",
	blue: "var(--color-brand-blue)",
	brown: "var(--color-brand-brown)",
};

const config: Config = {
	content: [
		"./keystatic.config.tsx",
		"./content/**/*.@(md|mdx)",
		"./src/@(components|layouts|pages)/**/*.@(astro|css|ts|tsx)",
		"./src/styles/**/*.css",
	],
	presets: [preset],
	theme: {
		extend: {
			colors: {
				brand: brandColors,
				negative: colors.red,
				positive: colors.green,
			},
			screens: {
				lg: "74rem",
			},
			typography: {
				DEFAULT: {
					css: {
						maxWidth: "none",
						/** Don't add quotes around `blockquote`. */
						"blockquote p:first-of-type::before": null,
						"blockquote p:last-of-type::after": null,
						/** Don't add backticks around inline `code`. */
						"code::before": null,
						"code::after": null,
						"--tw-prose-body": colors.neutral[500],
						"--tw-prose-headings": colors.neutral[500],
						"--tw-prose-bold": colors.neutral[500],
						"--tw-prose-links": brandColors.red,
						"p:first-of-type": {
							marginTop: "0",
						},
						a: {
							textDecoration: "none",
						},
						h1: {
							marginBottom: 0,
						},
						hr: {
							borderWidth: "3px",
							borderColor: "hsla(0, 0%, 0%, 0.05)",
						},
					},
				},
			},
		},
	},
};

export default config;
