#!/usr/bin/env nextflow
// hash:sha256:a056964d68e63856b2a6068f54b9363c53356b04fb2f8c62db9d129ff35bfe3c

// capsule - SWC Refinement - Merge reconstructions
process capsule_swc_refinement_merge_reconstructions_8 {
	tag 'capsule-5794521'
	container "$REGISTRY_HOST/capsule/fd96c849-0bf6-449c-b210-3addbd132630:81791a1284dcc9d555f7237c62ff5e81"

	cpus 2
	memory '15 GB'

	publishDir "$RESULTS_PATH", mode: 'copy', saveAs: { filename -> new File(filename).getName() }

	output:
	path 'capsule/results/*'
	path 'capsule/results/merged', emit: to_capsule_neuron_reconstruction_qc_capsule_11_15

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=fd96c849-0bf6-449c-b210-3addbd132630
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/swc-processing-test-asset-841260" "capsule/data/swc-processing-test-asset-841260" # id: 3a69aa68-d0d0-4440-b650-6976c931200e

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5794521.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5794521.git" capsule-repo
	fi
	git -C capsule-repo checkout 00c9b4c108112d8ec7643afed3ed33006385015c --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_swc_refinement_merge_reconstructions_8_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Neuron Reconstruction QC Capsule
process capsule_neuron_reconstruction_qc_capsule_11 {
	tag 'capsule-1223705'
	container "$REGISTRY_HOST/capsule/00a1b27a-7ad1-495a-bf51-21c137d7b094:0bdc75222d53fbd80c157cd9eab64f19"

	cpus 4
	memory '30 GB'

	cache 'deep'

	publishDir "$RESULTS_PATH", mode: 'copy', saveAs: { filename -> filename.matches("capsule/results/pre-refinement-qc") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/qc_config.json'
	path 'capsule/data/merged'

	output:
	path 'capsule/results/pre-refinement-qc/aind_data_schema', emit: to_capsule_combine_qc_metrics_6_9
	path 'capsule/results/swcs/*', emit: to_capsule_swc_refinment_10_13
	path 'capsule/results/pre-refinement-qc'

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
	git -C capsule-repo checkout 712468e95168849faf3d4296965b1e5c3eca3814 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_neuron_reconstruction_qc_capsule_11_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - SWC Refinment
process capsule_swc_refinment_10 {
	tag 'capsule-1168512'
	container "$REGISTRY_HOST/capsule/67f566a2-a348-489f-a720-11b2536f0859:a9f36c41c85da5533e06abde64de6ed4"

	cpus 32
	memory '240 GB'

	input:
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_merge_refinement_results_9_12

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=67f566a2-a348-489f-a720-11b2536f0859
	export CO_CPUS=32
	export CO_MEMORY=257698037760

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/Fiji-builds

	ln -s "/tmp/data/Fiji-builds/Fiji.app" "capsule/data/Fiji-builds/Fiji.app" # id: 83909dcc-1e88-4816-b247-63f6d0218eff

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1168512.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1168512.git" capsule-repo
	fi
	git -C capsule-repo checkout 1dacee8689b8fc46a60cadf0d00dca61d5906e43 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_swc_refinment_10_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Merge refinement results
process capsule_merge_refinement_results_9 {
	tag 'capsule-0909330'
	container "$REGISTRY_HOST/capsule/a06a073a-d943-4d16-92c9-dee104568d30:32d717c76adcfc0306c7381b9b96ba8b"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", mode: 'copy', saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/'

	output:
	path 'capsule/results/refinement', emit: to_capsule_exaspim_swc_transform_capsule_1_1
	path 'capsule/results/*'
	path 'capsule/results/refinement/final-world', emit: to_capsule_neuron_reconstruction_qc_capsule_12_17

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a06a073a-d943-4d16-92c9-dee104568d30
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0909330.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0909330.git" capsule-repo
	fi
	git -C capsule-repo checkout 99a458f1beb3b7e94556885fbbcaec7b11d457e8 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - exaspim-swc-transform
process capsule_exaspim_swc_transform_capsule_1 {
	tag 'capsule-2015425'
	container "$REGISTRY_HOST/capsule/cec1b540-f971-4a1c-8e85-60040ece90e4:dab6eadf477e22dfc83975186aa1d910"

	cpus 8
	memory '60 GB'

	input:
	path 'capsule/data/refinement'

	output:
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_resample_3_4

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

// capsule - Neuron Reconstruction QC Capsule
process capsule_neuron_reconstruction_qc_capsule_12 {
	tag 'capsule-1223705'
	container "$REGISTRY_HOST/capsule/00a1b27a-7ad1-495a-bf51-21c137d7b094:0bdc75222d53fbd80c157cd9eab64f19"

	cpus 4
	memory '30 GB'

	cache 'deep'

	publishDir "$RESULTS_PATH", mode: 'copy', saveAs: { filename -> filename.matches("capsule/results/post-refinement-qc") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/qc_config.json'
	path 'capsule/data/final-world'

	output:
	path 'capsule/results/post-refinement-qc'

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
	git -C capsule-repo checkout 712468e95168849faf3d4296965b1e5c3eca3814 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_neuron_reconstruction_qc_capsule_12_args}

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
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_packaging_2_3
	path 'capsule/results/*', emit: to_capsule_neuron_reconstruction_qc_capsule_4_5
	path 'capsule/results/*', emit: to_capsule_neuron_reconstruction_qc_capsule_5_7

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
	path 'capsule/results/transformed-qc/aind_data_schema/*', emit: to_capsule_combine_qc_metrics_6_10

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
	git -C capsule-repo checkout 712468e95168849faf3d4296965b1e5c3eca3814 --quiet
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
	path 'capsule/results/refined-qc/aind_data_schema/*', emit: to_capsule_combine_qc_metrics_6_11

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
	git -C capsule-repo checkout 712468e95168849faf3d4296965b1e5c3eca3814 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_neuron_reconstruction_qc_capsule_5_args}

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
	path 'capsule/data/raw-qc'
	path 'capsule/data/transformed-qc/'
	path 'capsule/data/refined-qc/'

	output:
	path 'capsule/results/*', emit: to_capsule_exaspim_swc_packaging_2_2

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
	tag 'capsule-9549814'
	container "$REGISTRY_HOST/capsule/f5236f44-5506-46c6-9e82-f18b5fbd38e4:0afdbc5c9ac53df3959408d554dc5cc0"

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

	export CO_CAPSULE_ID=f5236f44-5506-46c6-9e82-f18b5fbd38e4
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9549814.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9549814.git" capsule-repo
	fi
	git -C capsule-repo checkout 0e35a7effc9f4efa2a7744c6a64f4bbb5b0ad37b --quiet
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
	qc_configs_to_neuron_reconstruction_qc_capsule_6 = Channel.fromPath("../data/qc-configs/aligned-config.json", type: 'any')
	qc_configs_to_neuron_reconstruction_qc_capsule_8 = Channel.fromPath("../data/qc-configs/refined-config.json", type: 'any')
	qc_configs_to_neuron_reconstruction_qc_capsule_14 = Channel.fromPath("../data/qc-configs/pre-refinement-config.json", type: 'any')
	qc_configs_to_neuron_reconstruction_qc_capsule_16 = Channel.fromPath("../data/qc-configs/post-refinement-config.json", type: 'any')

	// run processes
	capsule_swc_refinement_merge_reconstructions_8()
	capsule_neuron_reconstruction_qc_capsule_11(qc_configs_to_neuron_reconstruction_qc_capsule_14, capsule_swc_refinement_merge_reconstructions_8.out.to_capsule_neuron_reconstruction_qc_capsule_11_15)
	capsule_swc_refinment_10(capsule_neuron_reconstruction_qc_capsule_11.out.to_capsule_swc_refinment_10_13.flatten())
	capsule_merge_refinement_results_9(capsule_swc_refinment_10.out.to_capsule_merge_refinement_results_9_12.collect())
	capsule_exaspim_swc_transform_capsule_1(capsule_merge_refinement_results_9.out.to_capsule_exaspim_swc_transform_capsule_1_1)
	capsule_neuron_reconstruction_qc_capsule_12(qc_configs_to_neuron_reconstruction_qc_capsule_16, capsule_merge_refinement_results_9.out.to_capsule_neuron_reconstruction_qc_capsule_12_17)
	capsule_exaspim_swc_resample_3(capsule_exaspim_swc_transform_capsule_1.out.to_capsule_exaspim_swc_resample_3_4)
	capsule_neuron_reconstruction_qc_capsule_4(capsule_exaspim_swc_resample_3.out.to_capsule_neuron_reconstruction_qc_capsule_4_5, qc_configs_to_neuron_reconstruction_qc_capsule_6)
	capsule_neuron_reconstruction_qc_capsule_5(capsule_exaspim_swc_resample_3.out.to_capsule_neuron_reconstruction_qc_capsule_5_7, qc_configs_to_neuron_reconstruction_qc_capsule_8)
	capsule_combine_qc_metrics_6(capsule_neuron_reconstruction_qc_capsule_11.out.to_capsule_combine_qc_metrics_6_9, capsule_neuron_reconstruction_qc_capsule_4.out.to_capsule_combine_qc_metrics_6_10, capsule_neuron_reconstruction_qc_capsule_5.out.to_capsule_combine_qc_metrics_6_11)
	capsule_exaspim_swc_packaging_2(capsule_combine_qc_metrics_6.out.to_capsule_exaspim_swc_packaging_2_2, capsule_exaspim_swc_resample_3.out.to_capsule_exaspim_swc_packaging_2_3)
}
