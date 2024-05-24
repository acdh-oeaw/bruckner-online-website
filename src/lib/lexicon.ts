type MaybeArray<T> = Array<T> | T;

export type Category = "Artikel" | "Autor" | "Literatur" | "Ort" | "Person" | "Sache" | "Werk";

export interface SearchResponse {
	request: {
		max: string;
		startAt: string;
		operation: "query";
		filters: { filter: MaybeArray<{ name: string; "#text": string }> };
	};
	results: {
		article: MaybeArray<{
			id: string;
			title: string;
			status: "released";
			position: string;
			kwic: {
				p: MaybeArray<{
					span: [
						{ "#text": string; class: "previous" },
						{ "#text": string; class: "hi" },
						{ "#text": string; class: "following" },
					];
				}>;
			};
			categories: { term: Category };
			authors: { author: MaybeArray<{ name: string; "#text": Array<string> }> };
		}>;
		total: string;
	};
}

export interface AuthorSearchResponse {
	request: {
		max: string;
		startAt: string;
		operation: "authors";
		name: string;
	};
	results: {
		item: MaybeArray<{
			id: string;
			position: string;
			person: {
				persName: [
					{ type: "sortName"; "#text": string },
					{ type: "full"; "#text": string },
					{ type: "abbreviation"; "#text": string },
				];
			};
		}>;
		total: string;
	};
}

export interface ArticleSearchResponse {
	request: {
		operation: "list";
		startAt: string;
		max: string;
		filters: { filter: MaybeArray<{ name: string; "#text": string }> };
	};
	results: {
		article: MaybeArray<{
			id: string;
			status: "released";
			type: "article";
			title: string;
			position: string;
			filename: string;
			author: {
				name: string;
			};
			category: Category;
		}>;
		total: string;
	};
}

export interface BibliographySearchResult {
	request: {
		operation: "literature";
		startAt: string;
		max: string;
		filters: { filter: MaybeArray<{ name: string; "#text": string }> };
	};
	results: {
		item: MaybeArray<{
			id: string;
			position: string;
			short: string;
			full: {
				bibl: {
					"xml:id": string;
					n: string;
					"#text": string;
				};
			};
		}>;
		total: string;
	};
}

export const baseUrl = "https://api-brucknerlex.acdh.oeaw.ac.at";

export const pathnames: Record<Category, string> = {
	Artikel: "/lexikon/artikel/",
	Autor: "/lexikon/autorinnen/",
	Literatur: "/lexikon/literatur/",
	Ort: "/lexikon/orte/",
	Person: "/lexikon/personen/",
	Sache: "/lexikon/sachbegriffe/",
	Werk: "/lexikon/werke/",
};
