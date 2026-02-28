#!/usr/bin/env nextflow


process qualityControl {
    input:
    path "HumanMap.fastq"

    output:
    path "HumanMap_fastqc.html"

    script:
    """
    fastqc 'HumanMap.fastqc'
    """

}

workflow {

    main:

    fastqc_ch = channel.fromPath('data/HumanMap.fastq')

    qualityControl(fastqc_ch)

    publish:

    second_output = qualityControl.out

}

output {
    second_output {
        path 'quality_control'
        mode 'copy'
    }
}
