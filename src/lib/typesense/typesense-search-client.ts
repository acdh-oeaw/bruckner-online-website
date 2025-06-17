import { Client as TypesenseClient } from "typesense";

export const typesenseSettings = {
	connectionTimeoutSeconds: 10,
	nodes: [
		{
			host: String(import.meta.env.PUBLIC_TYPESENSE_HOST),
			port: Number(import.meta.env.PUBLIC_TYPESENSE_PORT),
			protocol: String(import.meta.env.PUBLIC_TYPESENSE_PROTOCOL),
		},
	],
};

export function createTypesenseClient(
	apiKey = String(import.meta.env.PUBLIC_TYPESENSE_SEARCH_API_KEY),
): TypesenseClient {
	return new TypesenseClient({ ...typesenseSettings, apiKey });
}
