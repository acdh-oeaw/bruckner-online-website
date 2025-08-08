import { For } from "solid-js";

import editionIndex from "@/edition/edition_index.json";

interface CopyistSelectProps {
	name: string;
	selectedValue: string;
}

export default function CopyistSelect(props: CopyistSelectProps) {
	const { name, selectedValue } = props;
	return (
		<select
			data-kopisten-select
			name={name}
			class="w-full rounded-md bg-white p-2.5"
			onChange={(e) => {return (e.currentTarget as HTMLSelectElement).form?.submit()}}
		>
			<option disabled selected hidden>
				Kopist auswählen
			</option>
			<For each={editionIndex}>
				{(editionItem) => {
					const { id, copyist_name: copyistName } = editionItem;
					return (
						<option value={id} selected={selectedValue === id}>
							{copyistName}
						</option>
					);
				}}
			</For>
		</select>
	);
}
