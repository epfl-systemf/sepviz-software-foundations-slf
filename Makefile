COQFLAGS := -Q . SLF
COQMFFLAGS := $(COQFLAGS) -arg "-w -implicit-core-hint-db,-ambiguous-paths,-notation-incompatible-prefix,-automatic-prop-lowering"

ALLVFILES := LibAxioms.v LibTactics.v LibEqual.v LibLogic.v LibOperation.v LibBool.v LibReflect.v LibProd.v LibSum.v LibRelation.v LibOrder.v LibNat.v LibEpsilon.v LibInt.v LibMonoid.v LibContainer.v LibOption.v LibWf.v LibList.v LibListExec.v LibListZ.v LibMin.v LibSet.v LibChoice.v LibUnit.v LibFun.v LibString.v LibMultiset.v LibCore.v LibSepTLCbuffer.v LibSepFmap.v LibSepVar.v LibSepSimpl.v LibSepMinimal.v LibSepReference.v Preface.v Basic.v Repr.v Hprop.v Himpl.v Triples.v Rules.v Wand.v WPsem.v WPgen.v WPsound.v Affine.v Arrays.v Records.v Postscript.v Bib.v

ALLVFILES += SepViz_Notations.v
ALLVOFILES := $(patsubst %.v,%.vo,$(ALLVFILES))

build: Makefile.coq
	$(MAKE) -f Makefile.coq

clean::
	if [ -e Makefile.coq ]; then $(MAKE) -f Makefile.coq cleanall; fi
	$(RM) $(wildcard Makefile.coq Makefile.coq.conf)

Makefile.coq:
	coq_makefile $(COQMFFLAGS) -o Makefile.coq $(ALLVFILES)

-include Makefile.coq

.PHONY: build clean sepviz


ALECTRYON_FLAGS := $(COQFLAGS) --webpage-style windowed --long-line-threshold 100
SEPVIZ_OUT_DIR  := _sepviz_build
SEPVIZ_MODULES  := Repr
SEPVIZ_HTMLS    := $(patsubst %,$(SEPVIZ_OUT_DIR)/SoftwareFoundations-SLF-%.html,$(SEPVIZ_MODULES))

$(SEPVIZ_OUT_DIR):
	mkdir -p $@

$(SEPVIZ_OUT_DIR)/SoftwareFoundations-SLF-%.html: %.v $(ALLVOFILES)
	alectryon $(ALECTRYON_FLAGS) --output $@ $<

sepviz: $(SEPVIZ_HTMLS)
