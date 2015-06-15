

all: html pdf docx rtf

pdf: target/resume.pdf
target/resume.pdf: target/resume.md
	pandoc --standalone --template style_chmduquesne.tex \
	--from markdown --to context \
	-V papersize=A4 \
	-o target/resume.tex target/resume.md; \
	context target/resume.tex
	mv resume.pdf resume.tuc resume.log target/

html: target/resume.html
target/resume.html: style_chmduquesne.css target/resume.md
	pandoc --standalone -H style_chmduquesne.css \
        --from markdown --to html \
        -o target/resume.html target/resume.md

docx: target/resume.docx
target/resume.docx: target/resume.md
	pandoc -s -S target/resume.md -o target/resume.docx

rtf: target/resume.rtf
target/resume.rtf: target/resume.md
	pandoc -s -S target/resume.md -o target/resume.rtf

target/resume.md:
	build_resume.bash

clean:
	rm -f target/resume.html
	rm -f target/resume.tex
	rm -f target/resume.tuc
	rm -f target/resume.log
	rm -f target/resume.pdf
	rm -f target/resume.docx
	rm -f target/resume.rtf
	rm -f target/resume.md
	rmdir --ignore-fail-on-non-empty target
