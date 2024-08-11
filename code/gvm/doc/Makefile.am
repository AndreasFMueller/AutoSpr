#
# Makefile.am -- makefile to include the documentation in the package
#
# (c) 2012-2024 Prof Dr Andreas Mueller
#
EXTRA_DIST = \
	gvm.tex \
	assign.h condgoto.h engine.h goto.h node.h nodes.h vm.h tm.h \
	parser.y parsergoto.y \
	tmc-beaver.tm \
	print.goto steuerung.goto beispiel.goto tmc-command.goto \
	tmc-initial.goto tmc-isolate.goto tmc-move.goto tmc-printtm.goto \
	tmc-splice.goto tmc-state.goto \
	gvm.1 tmc.1

gvm.pdf:	gvm.tex
	pdflatex gvm.tex
	pdflatex gvm.tex

man_MANS = gvm.1 tmc.1
