export const figureAlignments = [
	{ label: "Center", value: "center" },
	{ label: "Stretch", value: "stretch" },
] as const;

export type FigureAlignment = (typeof figureAlignments)[number]["value"];

export const linkKinds = [
	{ label: "Download", value: "download" },
	{ label: "External", value: "external" },
	{ label: "Home page", value: "index-page" },
	{ label: "Pages", value: "pages" },
] as const;

export type LinkKind = (typeof linkKinds)[number]["value"];

export const videoProviders = [{ label: "YouTube", value: "youtube" }] as const;

export type VideoProvider = (typeof videoProviders)[number]["value"];
