import { createUrl } from "@acdh-oeaw/lib";

import { expect, test } from "~/e2e/lib/test";

// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
const baseUrl = process.env.PUBLIC_APP_BASE_URL!;

test("should set a canonical url", async ({ createIndexPage }) => {
	const { indexPage } = await createIndexPage();
	await indexPage.goto();

	const canonicalUrl = indexPage.page.locator('link[rel="canonical"]');
	await expect(canonicalUrl).toHaveAttribute("href", String(createUrl({ baseUrl, pathname: "/" })));
});

test("should set document title on not-found page", async ({ page }) => {
	await page.goto("/unknown/");
	await expect(page).toHaveTitle("Seite nicht gefunden | Bruckner Online");
});

test("should disallow indexing of not-found page", async ({ page }) => {
	await page.goto("/unknown/");

	const ogTitle = page.locator('meta[name="robots"]');
	await expect(ogTitle).toHaveAttribute("content", "noindex");
});

test("should set page metadata", async ({ createIndexPage }) => {
	const { indexPage } = await createIndexPage();
	await indexPage.goto();

	const { page } = indexPage;

	const ogType = page.locator('meta[property="og:type"]');
	await expect(ogType).toHaveAttribute("content", "website");

	const twCard = page.locator('meta[name="twitter:card"]');
	await expect(twCard).toHaveAttribute("content", "summary_large_image");

	// const twCreator = page.locator('meta[name="twitter:creator"]');
	// await expect(twCreator).toHaveAttribute("content", "@acdh_oeaw");

	// const twSite = page.locator('meta[name="twitter:site"]');
	// await expect(twSite).toHaveAttribute("content", "@acdh_oeaw");

	// const googleSiteVerification = page.locator('meta[name="google-site-verification"]');
	// await expect(googleSiteVerification).toHaveAttribute("content", "");

	await expect(page).toHaveTitle("Startseite | Bruckner Online");

	const metaDescription = page.locator('meta[name="description"]');
	await expect(metaDescription).toHaveAttribute(
		"content",
		"bruckner-online.at ist ein umfangreich angelegtes Bruckner-Internet-Portal (Webarchiv), in dem neben der elektronischen Dokumentation sämtlicher hand­schriftlicher Quellen auch alle Kompositionen, relevante Personen und Orte enthalten sind. Zudem werden von allen Quellen, Erstdrucken und der Alten Gesamtausgabe vollständige Digitalisate zur Verfügung gestellt.",
	);

	const ogTitle = page.locator('meta[property="og:title"]');
	await expect(ogTitle).toHaveAttribute("content", "Startseite");

	const ogDescription = page.locator('meta[property="og:description"]');
	await expect(ogDescription).toHaveAttribute(
		"content",
		"bruckner-online.at ist ein umfangreich angelegtes Bruckner-Internet-Portal (Webarchiv), in dem neben der elektronischen Dokumentation sämtlicher hand­schriftlicher Quellen auch alle Kompositionen, relevante Personen und Orte enthalten sind. Zudem werden von allen Quellen, Erstdrucken und der Alten Gesamtausgabe vollständige Digitalisate zur Verfügung gestellt.",
	);

	const ogSiteName = page.locator('meta[property="og:site_name"]');
	await expect(ogSiteName).toHaveAttribute("content", "Bruckner Online");

	const ogUrl = page.locator('meta[property="og:url"]');
	await expect(ogUrl).toHaveAttribute("content", String(createUrl({ baseUrl, pathname: "/" })));

	const ogLocale = page.locator('meta[property="og:locale"]');
	await expect(ogLocale).toHaveAttribute("content", "de");
});

test("should add json+ld metadata", async ({ createIndexPage }) => {
	const { indexPage } = await createIndexPage();
	await indexPage.goto();

	const metadata = await indexPage.page.locator('script[type="application/ld+json"]').textContent();
	// eslint-disable-next-line playwright/prefer-web-first-assertions
	expect(metadata).toBe(
		JSON.stringify({
			"@context": "https://schema.org",
			"@type": "WebSite",
			name: "Bruckner Online",
			description:
				"bruckner-online.at ist ein umfangreich angelegtes Bruckner-Internet-Portal (Webarchiv), in dem neben der elektronischen Dokumentation sämtlicher hand­schriftlicher Quellen auch alle Kompositionen, relevante Personen und Orte enthalten sind. Zudem werden von allen Quellen, Erstdrucken und der Alten Gesamtausgabe vollständige Digitalisate zur Verfügung gestellt.",
		}),
	);
});

test("should serve an open-graph image", async ({ createIndexPage, request }) => {
	const imagePath = "/opengraph-image.png";

	const { indexPage } = await createIndexPage();
	await indexPage.goto();

	await expect(indexPage.page.locator('meta[property="og:image"]')).toHaveAttribute(
		"content",
		expect.stringContaining(String(createUrl({ baseUrl, pathname: imagePath }))),
	);

	const response = await request.get(imagePath);
	const status = response.status();
	const contentType = response.headers()["content-type"];

	expect(status).toBe(200);
	expect(contentType).toBe("image/png");
});

test("should set `lang` attribute on `html` element", async ({ createIndexPage }) => {
	const { indexPage } = await createIndexPage();
	await indexPage.goto();

	await expect(indexPage.page.locator("html")).toHaveAttribute("lang", "de");
});
