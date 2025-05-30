import type { APIContext, MiddlewareNext } from "astro";

export function onRequest(context: APIContext, next: MiddlewareNext) {
	const { url, redirect } = context;
	if (url.pathname.startsWith("/wab-")) {
		return redirect(`/werkverzeichnis/wab?WAB=${url.pathname.replace("/", "")}`);
	}

	return next();
}
