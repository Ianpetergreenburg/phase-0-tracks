cell = {
	plant: {
		cytoplasm: {
			golgi:"packages molecules",
			 endoplasmic_reticulum:
			 	["Rough", "Smooth"],
			 ribosomes:"turn mRNA into proteins",
			 lysosomes:"breakdown old machinery",
			 mitochondria:"powerhouse of the cell",
			 chloroplast:"store energy from sunlight",
			 vacuole:"control homeostasis"
			},
		cell_membrane: {
			cell_wall: {
				middle_layer: {"Primary Cell Wall"=>"thin, extensible layer"},
				inner_layer: {"Secondary Cell Wall"=>"waterproofs some cell"},
				outer_layer: {"Middle Lamella"=>"Pectin-rich layer that glues to other cells"},
				composition: {"Cellulose"=>"35-50%","xylan"=>"20-35%","lignin"=>"10-25%"}
				},
			function: "cell-to-cell transport"
		},
		nucleus: {nucleolus: "holds DNA" }
	},	
	animal: {
		cytoplasm: {
			golgi:"packages molecules",
			 endoplasmic_reticulum:
			 	["Rough", "Smooth"],
			 ribosomes:"turn mRNA into proteins",
			 lysosomes:"breakdown old machinery",
			 mitochondria:"powerhouse of the cell",
			},
		cell_membrane: 
			{function: "cell-to-cell transport"},
		nucleus: {
			nucleolus: "holds DNA" 
		}
	}
}

p cell[:plant][:cell_membrane][:cell_wall][:composition]["Cellulose"]
p cell[:animal][:cytoplasm][:endoplasmic_reticulum][1]
cell[:animal][:cytoplasm].each {|x| p x}
cell[:animal][:nucleus][:chromosomes] = "is DNA"
cell[:plant][:nucleus][:chromosomes] = cell[:animal][:nucleus][:chromosomes]
cell[:animal][:cytoplasm][:golgi].upcase!
p cell