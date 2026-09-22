#!/usr/bin/env nextflow
// hash:sha256:24c2953de84e395df33feeea1a3ed0f393a9e2954eb8ab6630ce0377424f8eee

// capsule - exaspim-swc-transform
process capsule_exaspim_swc_transform_capsule_1 {
	tag 'capsule-2015425'
	container "$REGISTRY_HOST/capsule/cec1b540-f971-4a1c-8e85-60040ece90e4"

	cpus 16
	memory '120 GB'

	input:
	val path1
	val path2

	output:
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_resample_3_4

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

	ln -s "/tmp/data/exaspim_template_7subjects_nomask_10um_round6_template_only/$path1" "capsule/data/$path1" # id: 725d783a-a2df-4c64-a5d8-cdc0f35afd3a
	ln -s "/tmp/data/reg_exaspim_template_to_ccf_25um_v1.5/$path2" "capsule/data/$path2" # id: 0b22b6d4-5866-4a31-90ad-7be655a32539

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
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_packaging_2_3

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
	// input data
	exaspim_template_7subjects_nomask_10um_round6_template_only_to_exaspim_swc_transform_1 = Channel.fromPath("../data/exaspim_template_7subjects_nomask_10um_round6_template_only/*", type: 'any', relative: true)
	reg_exaspim_template_to_ccf_25um_v1_5_to_exaspim_swc_transform_2 = Channel.fromPath("../data/reg_exaspim_template_to_ccf_25um_v1.5/*", type: 'any', relative: true)

	// run processes
	capsule_exaspim_swc_transform_capsule_1(exaspim_template_7subjects_nomask_10um_round6_template_only_to_exaspim_swc_transform_1, reg_exaspim_template_to_ccf_25um_v1_5_to_exaspim_swc_transform_2)
	capsule_exaspim_swc_resample_3(capsule_exaspim_swc_transform_capsule_1.out.to_capsule_exaspim_swc_resample_3_4)
	capsule_exaspim_swc_packaging_2(capsule_exaspim_swc_resample_3.out.to_capsule_exaspim_swc_packaging_2_3)
}
