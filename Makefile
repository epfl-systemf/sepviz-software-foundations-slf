COQMFFLAGS := -Q . SLF  -arg "-w -implicit-core-hint-db,-ambiguous-paths"
COQ_ALECTRYON_FLAGS := -Q . SLF

ALLVFILES := LibAxioms.v LibTactics.v LibEqual.v LibLogic.v LibOperation.v LibBool.v LibReflect.v LibProd.v LibSum.v LibRelation.v LibOrder.v LibNat.v LibEpsilon.v LibInt.v LibMonoid.v LibContainer.v LibOption.v LibWf.v LibList.v LibListExec.v LibListZ.v LibMin.v LibSet.v LibChoice.v LibUnit.v LibFun.v LibString.v LibMultiset.v LibCore.v LibSepTLCbuffer.v LibSepFmap.v LibSepVar.v LibSepSimpl.v LibSepMinimal.v LibSepReference.v SepViz_Notations.v Preface.v Basic.v Repr.v Hprop.v Himpl.v Rules.v WPsem.v WPgen.v Wand.v Affine.v Struct.v Rich.v Nondet.v Partial.v Postscript.v Bib.v

build: Makefile.coq
	$(MAKE) -f Makefile.coq

clean::
	if [ -e Makefile.coq ]; then $(MAKE) -f Makefile.coq cleanall; fi
	$(RM) $(wildcard Makefile.coq Makefile.coq.conf)

Makefile.coq:
	coq_makefile $(COQMFFLAGS) -o Makefile.coq $(ALLVFILES)

-include Makefile.coq

.PHONY: build clean sepviz

SEPVIZ_OUT_DIR = _sepviz_build

$(SEPVIZ_OUT_DIR):
	mkdir -p $@

$(SEPVIZ_OUT_DIR)/SoftwareFoundations-SLF-Repr.html: Repr.v
	alectryon $(COQ_ALECTRYON_FLAGS) --output $@ $<

# $(SEPVIZ_OUT_DIR)/%.html: %.v
# 	alectryon $(COQ_ALECTRYON_FLAGS) --output $@ $<

SEPVIZ_MODULES := Repr
# SEPVIZ_HTMLS   := $(addprefix $(SEPVIZ_OUT_DIR)/,$(addsuffix .html,$(SEPVIZ_MODULES)))
SEPVIZ_HTMLS   := $(SEPVIZ_OUT_DIR)/SoftwareFoundations-SLF-Repr.html

sepviz: $(SEPVIZ_HTMLS)
