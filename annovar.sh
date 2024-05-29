# first step is to go to annovar main website https://annovar.openbioinformatics.org/en/latest/ then in order to download annovar first you have to #sign up using unisversity login id, their you will get the link the downloading link alternatively, you can use the below command to install #annovar
#Here is the link to download ANNOVAR: http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz
#Please cite ANNOVAR paper in your publication: Wang K, Li M, Hakonarson H. ANNOVAR: Functional annotation of genetic variants from next-generation# #sequencing data, Nucleic Acids Research, 38:e164, 2010
#-Kai
# wget on your terminal download annovar using this command 
#               wget http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz
# once you download it untar the .gz file using  this command tar xvfz annovar.latest.tar.gz
# after untaring we need to add the annovar path to the .bashrc file so that it can then run from anywhere on your computer 
# using your own path to annovar change this path and run it, if you dont know the path to your annovar directory then run after going to annovar #folder run pwd command and you will find your path to annovar,after finding that path change the according to yours and then run this command 
#   echo 'export PATH=/media/wajid/data/annotation/annovar:$PATH' >> ~/.bashrc then in order to premanently sava it by staying in the terminal run this command                        source ~/.bashrc
#Verify the changes by running:
#echo $PATH
# now everything is set lets dive into what we have in our annovar directory; it has one folder by the name of example and another one by the name #of human db, one thing keeping in mind for the begginers that annovar has provided everything for you in order to get first-hand beginner level #experience using hg19 genome assembly 
# before ding anything you can run this command from annovar directory and it will annotate your file using genome assembly 19 gene-based, region-#based and then filter-based annotation.
#table_annovar.pl example/ex1.avinput humandb/ -buildver hg19 -out myanno -remove -protocol refGene,cytoBand,exac03,avsnp147,dbnsfp30a -operation #gx,r,f,f,f -nastring . -csvout -polish -xref example/gene_xref.txt
#but this is not the updated assembly so we have to download the updated one first that is hg38, wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.chromFa.tar.gz unzip it using the command above mentioned. after donloadind this we need to downlaod the databases for annovar in #order to annotate our sample from them. so for this purpose we need to download the databases and the command is 
#annotate_variation.pl -buildver hg38 -downdb -webfrom annovar refGene humandb/
#annotate_variation.pl -buildver hg38 -downdb -webfrom annovar ensGene humandb/
#annotate_variation.pl -buildver hg38 -downdb -webfrom annovar KnownGene humandb/
#and so on so forthe all the databases are present in protocol section down below one-by-one. 
#Disclaimer!these databases are big so you need to have atleast 400gb space on your computer 
# after you have downloaded all the databases now is the time to annotate sample 
#!/bin/bash
#this script is considering that your input file is annovar-input or avinput, if you wish to proceed with vcf file and not changing it to the avinput then a few adjustment would be required; in-place of input_avinput yours one should be input_vcf and the second that is more important is with vcf file annovar does not give option of generating csv file so if you input is vcf then you have to remove line number 59 that -csvout totally and at the end of the script you should add -vcfinput which would literallt tells to your annovar that my input is vcf and i want the output in vcf.
# one last thing if by any chance you want to convert your .vcf file into avinput here is the command to convert it .
#    perl convert2annovar.pl -format vcf4 -allsample -withfreq name_of_your_vcf_file.vcf > output_name_that_you_want.avinput


# Path to the directory containing table_annovar.pl

annovar_dir="/media/wajid/data/annotation/annovar"

# Path to the VCF/avinput file; change these paths according to yours
input_avinput="/media/wajid/data/annotation/annovar/example/anemia.avinput"

# Path to the humandb directory; change these paths according to yours
humandb="/media/wajid/data/annotation/annovar/humandb"

# Build version
build="hg38"

# Output file name ; change these paths according to yours
output_file="/media/wajid/data/annotation/working_dir"

# ANNOVAR protocol configuration
protocol=('refGene' 'knownGene' 'ensGene' 'refGeneWithVer' 'cytoBand' 'abraom' 'clinvar_20221231' 'avsnp150' 'esp6500siv2_all' 'gnomad40_exome' 'gnomad40_genome' 'gme' 'dbscsnv11' 'intervar_20180118' 'cosmic70' 'icgc28' 'revel' 'dbnsfp42a' 'regsnpintron' 'mcap' 'ALL.sites.2015_08' 'hrcr1' 'kaviar_20150923' 'gene4denovo201907')
operation=('gx' 'g' 'g' 'g' 'r' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f' 'f')

# Xref file for gene annotation
xreffile="/media/wajid/data/annotation/annovar/example/gene_fullxref.txt"

# Run table_annovar.pl command with -vcfinput
"$annovar_dir/table_annovar.pl" \
    "$input_avinput" \
    "$humandb" \
    -buildver "$build" \
    -out "$output_file" \
    -remove \
    -protocol "$(IFS=,; echo "${protocol[*]}")" \
    -operation "$(IFS=,; echo "${operation[*]}")" \
    -nastring . \
    -csvout \
    -polish \
    -xreffile "$xreffile" \
    -arg '-splicing 12' \
    -arg '-exonicsplicing' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' \
    -arg '' 




