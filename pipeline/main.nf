#!/usr/bin/env nextflow
// hash:sha256:d6a5423202e9c753573feddaf6e6814946911fa49bd18213380c093357577d28

// capsule - exaspim-swc-transform
process capsule_exaspim_swc_transform_capsule_1 {
	tag 'capsule-2015425'
	container "$REGISTRY_HOST/capsule/cec1b540-f971-4a1c-8e85-60040ece90e4:dab6eadf477e22dfc83975186aa1d910"

	cpus 8
	memory '60 GB'

	output:
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_resample_3_3

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=cec1b540-f971-4a1c-8e85-60040ece90e4
	export CO_CPUS=8
	export CO_MEMORY=64424509440

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/exaSPIM_841260_reconstructions_refined_2026_09_17/refinement" "capsule/data/refinement" # id: ef926cf6-ae1b-4d9b-b716-97316b2ff046
	ln -s "/tmp/data/reg_exaspim_template_to_ccf_withGradMap_10um_v1.0" "capsule/data/reg_exaspim_template_to_ccf_withGradMap_10um_v1.0" # id: 30dd60f8-d85d-46e6-8a6d-3af4b7577f04
	ln -s "/tmp/data/reg_exaspim_template_to_ccf_25um_v1.4" "capsule/data/reg_exaspim_template_to_ccf_25um_v1.4" # id: a07157ab-990e-45d8-8e4c-53ebef2b74df
	ln -s "/tmp/data/reg_exaspim_template_to_ccf_25um_v1.3" "capsule/data/reg_exaspim_template_to_ccf_25um_v1.3" # id: ee48989d-ae51-4d6b-a520-adaf64831bc1
	ln -s "/tmp/data/reg_exaspim_template_to_ccf_25um_v1.2" "capsule/data/reg_exaspim_template_to_ccf_25um_v1.2" # id: f49b1346-e9ef-4201-b49b-a70fc6d12ae9
	ln -s "/tmp/data/reg_exaspim_template_to_ccf_25um_v1.1" "capsule/data/reg_exaspim_template_to_ccf_25um_v1.1" # id: 90e5a323-b4a9-441e-baea-4f9717cda04f
	ln -s "/tmp/data/allen_mouse_ccf" "capsule/data/allen_mouse_ccf" # id: 79bf9032-5cff-4038-b2b8-8a24fa098e3b
	ln -s "/tmp/data/exaspim_template_7subjects_nomask_10um_round6_template_only" "capsule/data/exaspim_template_7subjects_nomask_10um_round6_template_only" # id: 725d783a-a2df-4c64-a5d8-cdc0f35afd3a
	ln -s "/tmp/data/reg_exaspim_template_to_ccf_25um_v1.5" "capsule/data/reg_exaspim_template_to_ccf_25um_v1.5" # id: 0b22b6d4-5866-4a31-90ad-7be655a32539

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2015425.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2015425.git" capsule-repo
	fi
	git -C capsule-repo checkout f55a182c8eb7b60679ff3b6c325fe333f5c98efa --quiet
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
	container "$REGISTRY_HOST/capsule/47fb449f-8e2d-4430-8fdd-b047ca545c18:24f4ac174cc7f8748f331b85a21d3016"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_packaging_2_2
	path 'capsule/results/*', emit: to_capsule_neuron_reconstruction_qc_capsule_4_4
	path 'capsule/results/*', emit: to_capsule_neuron_reconstruction_qc_capsule_5_6
	path 'capsule/results/*', emit: to_capsule_neuron_reconstruction_qc_capsule_7_12

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
	git -C capsule-repo checkout 42d5ce74f1dcc77de93d69b4bd23a2e7ff91c715 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_exaspim_swc_resample_3_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Neuron Reconstruction QC Capsule
process capsule_neuron_reconstruction_qc_capsule_4 {
	tag 'capsule-1223705'
	container "$REGISTRY_HOST/capsule/00a1b27a-7ad1-495a-bf51-21c137d7b094:0bdc75222d53fbd80c157cd9eab64f19"

	cpus 4
	memory '30 GB'

	cache 'deep'

	input:
	path 'capsule/data/'
	path 'capsule/data/qc_config.json'

	output:
	path 'capsule/results/transformed-qc/aind_data_schema/*', emit: to_capsule_combine_qc_metrics_6_8

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=00a1b27a-7ad1-495a-bf51-21c137d7b094
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1223705.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1223705.git" capsule-repo
	fi
	git -C capsule-repo checkout c3758f6b813b251468e1b70ac863d74c650bcfab --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_neuron_reconstruction_qc_capsule_4_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Neuron Reconstruction QC Capsule
process capsule_neuron_reconstruction_qc_capsule_5 {
	tag 'capsule-1223705'
	container "$REGISTRY_HOST/capsule/00a1b27a-7ad1-495a-bf51-21c137d7b094:0bdc75222d53fbd80c157cd9eab64f19"

	cpus 4
	memory '30 GB'

	cache 'deep'

	input:
	path 'capsule/data/'
	path 'capsule/data/qc_config.json'

	output:
	path 'capsule/results/refined-qc/aind_data_schema/*', emit: to_capsule_combine_qc_metrics_6_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=00a1b27a-7ad1-495a-bf51-21c137d7b094
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1223705.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1223705.git" capsule-repo
	fi
	git -C capsule-repo checkout c3758f6b813b251468e1b70ac863d74c650bcfab --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_neuron_reconstruction_qc_capsule_5_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Neuron Reconstruction QC Capsule
process capsule_neuron_reconstruction_qc_capsule_7 {
	tag 'capsule-1223705'
	container "$REGISTRY_HOST/capsule/00a1b27a-7ad1-495a-bf51-21c137d7b094:0bdc75222d53fbd80c157cd9eab64f19"

	cpus 4
	memory '30 GB'

	cache 'deep'

	input:
	path 'capsule/data/qc_config.json'
	path 'capsule/data/'

	output:
	path 'capsule/results/raw-qc/aind_data_schema/*', emit: to_capsule_combine_qc_metrics_6_10

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=00a1b27a-7ad1-495a-bf51-21c137d7b094
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1223705.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1223705.git" capsule-repo
	fi
	git -C capsule-repo checkout c3758f6b813b251468e1b70ac863d74c650bcfab --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_neuron_reconstruction_qc_capsule_7_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Combine QC Metrics
process capsule_combine_qc_metrics_6 {
	tag 'capsule-8372130'
	container "$REGISTRY_HOST/capsule/12d0c12d-45e4-4ec1-8412-f01b886e7d34:716b737eaa2156fe8a3fd4e806b21e68"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/transformed-qc/'
	path 'capsule/data/refined-qc/'
	path 'capsule/data/raw-qc/'

	output:
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_packaging_2_1

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=12d0c12d-45e4-4ec1-8412-f01b886e7d34
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8372130.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8372130.git" capsule-repo
	fi
	git -C capsule-repo checkout 38a6f639f5049279ca162738a8cd94b688ea6204 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - exaspim-swc-packaging
process capsule_exaspim_swc_packaging_2 {
	tag 'capsule-9464795'
	container "$REGISTRY_HOST/capsule/449ebf74-967d-44bb-9d03-f69c49412589:3b0d82f0a4bc6bd6aef79519e0adf3d0"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", mode: 'copy', saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/'
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
	git -C capsule-repo checkout a9b56fc9ff202e9e8e2d8b2523754fd9504ca8b5 --quiet
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
	qc_configs_to_neuron_reconstruction_qc_capsule_5 = Channel.fromPath("../data/qc-configs/aligned-config.json", type: 'any')
	qc_configs_to_neuron_reconstruction_qc_capsule_7 = Channel.fromPath("../data/qc-configs/refined-config.json", type: 'any')
	qc_configs_to_neuron_reconstruction_qc_capsule_11 = Channel.fromPath("../data/qc-configs/raw-config.json", type: 'any')

	// run processes
	capsule_exaspim_swc_transform_capsule_1()
	capsule_exaspim_swc_resample_3(capsule_exaspim_swc_transform_capsule_1.out.to_capsule_exaspim_swc_resample_3_3)
	capsule_neuron_reconstruction_qc_capsule_4(capsule_exaspim_swc_resample_3.out.to_capsule_neuron_reconstruction_qc_capsule_4_4, qc_configs_to_neuron_reconstruction_qc_capsule_5)
	capsule_neuron_reconstruction_qc_capsule_5(capsule_exaspim_swc_resample_3.out.to_capsule_neuron_reconstruction_qc_capsule_5_6, qc_configs_to_neuron_reconstruction_qc_capsule_7)
	capsule_neuron_reconstruction_qc_capsule_7(qc_configs_to_neuron_reconstruction_qc_capsule_11, capsule_exaspim_swc_resample_3.out.to_capsule_neuron_reconstruction_qc_capsule_7_12)
	capsule_combine_qc_metrics_6(capsule_neuron_reconstruction_qc_capsule_4.out.to_capsule_combine_qc_metrics_6_8, capsule_neuron_reconstruction_qc_capsule_5.out.to_capsule_combine_qc_metrics_6_9, capsule_neuron_reconstruction_qc_capsule_7.out.to_capsule_combine_qc_metrics_6_10)
	capsule_exaspim_swc_packaging_2(capsule_combine_qc_metrics_6.out.to_capsule_exaspim_swc_packaging_2_1, capsule_exaspim_swc_resample_3.out.to_capsule_exaspim_swc_packaging_2_2)
}
