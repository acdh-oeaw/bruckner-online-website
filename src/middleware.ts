import type { APIContext, MiddlewareNext } from "astro";

export function onRequest(context: APIContext, next: MiddlewareNext) {
	const { url, redirect } = context;

	if (/wab-\d+$/.test(url.pathname)) {
		return redirect(`/werkverzeichnis/wab?WAB=${url.pathname.replace("/", "")}`);
	}

	if (/ABLO_[a-z\d]+$/.test(url.pathname)) {
		return redirect(`/lexikon/artikel/${url.pathname.replace("/ABLO_", "")}`);
	}

	return next();
}
