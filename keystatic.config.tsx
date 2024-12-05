/* @jsxImportSource react */

import { withI18nPrefix } from "@acdh-oeaw/keystatic-lib";
import { config } from "@keystatic/core";

import { env } from "@/config/env.config";
import { createPages } from "@/lib/keystatic/collections";
import { Logo } from "@/lib/keystatic/logo";
import { createIndexPage, createMetadata, createNavigation } from "@/lib/keystatic/singletons";

export default config({
	collections: {
		[withI18nPrefix("pages", "de")]: createPages("de"),
	},
	singletons: {
		[withI18nPrefix("index-page", "de")]: createIndexPage("de"),
		[withI18nPrefix("metadata", "de")]: createMetadata("de"),
		[withI18nPrefix("navigation", "de")]: createNavigation("de"),
	},
	storage:
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
	ui: {
		brand: {
			mark() {
				return <Logo />;
			},
			name: "Bruckner Online",
		},
		navigation: {
			Pages: [withI18nPrefix("index-page", "de"), withI18nPrefix("pages", "de")],
			Navigation: [withI18nPrefix("navigation", "de")],
			Settings: [withI18nPrefix("metadata", "de")],
		},
	},
});
