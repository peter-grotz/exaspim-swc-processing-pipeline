#!/usr/bin/env nextflow
// hash:sha256:740793c2849e425073f7fa0c38480c76a7291e9171e7c92f70f14bfcadb6e3e7

// capsule - exaspim-swc-transform
process capsule_exaspim_swc_transform_capsule_1 {
	tag 'capsule-2015425'
	container "$REGISTRY_HOST/capsule/cec1b540-f971-4a1c-8e85-60040ece90e4"

	cpus 16
	memory '120 GB'

	output:
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_resample_3_2

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=cec1b540-f971-4a1c-8e85-60040ece90e4
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/allen_mouse_ccf" "capsule/data/allen_mouse_ccf" # id: 79bf9032-5cff-4038-b2b8-8a24fa098e3b
	ln -s "/tmp/data/exaspim_template_7subjects_nomask_10um_round6_template_only" "capsule/data/exaspim_template_7subjects_nomask_10um_round6_template_only" # id: 725d783a-a2df-4c64-a5d8-cdc0f35afd3a
	ln -s "/tmp/data/reg_exaspim_template_to_ccf_25um_v1.5" "capsule/data/reg_exaspim_template_to_ccf_25um_v1.5" # id: 0b22b6d4-5866-4a31-90ad-7be655a32539

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2015425.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2015425.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_exaspim_swc_transform_capsule_1_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - exaspim-swc-resample
process capsule_exaspim_swc_resample_3 {
	tag 'capsule-9001304'
	container "$REGISTRY_HOST/capsule/47fb449f-8e2d-4430-8fdd-b047ca545c18"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_packaging_2_1

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=47fb449f-8e2d-4430-8fdd-b047ca545c18
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/Fiji-builds" "capsule/data/Fiji-builds" # id: 83909dcc-1e88-4816-b247-63f6d0218eff

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9001304.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9001304.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_exaspim_swc_resample_3_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - exaspim-swc-packaging
process capsule_exaspim_swc_packaging_2 {
	tag 'capsule-9464795'
	container "$REGISTRY_HOST/capsule/449ebf74-967d-44bb-9d03-f69c49412589"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", mode: 'copy', saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/'

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=449ebf74-967d-44bb-9d03-f69c49412589
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9464795.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9464795.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_exaspim_swc_packaging_2_args}

	echo "[${task.tag}] completed!"
	"""
}

workflow {
	// run processes
	capsule_exaspim_swc_transform_capsule_1()
	capsule_exaspim_swc_resample_3(capsule_exaspim_swc_transform_capsule_1.out.to_capsule_exaspim_swc_resample_3_2)
	capsule_exaspim_swc_packaging_2(capsule_exaspim_swc_resample_3.out.to_capsule_exaspim_swc_packaging_2_1)
}
