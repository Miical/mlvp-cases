VSRC_DIR = ./vsrc
PICKER 	 = picker
NAME	 = Cache
NAME_L 	 = cache

run:
	pytest --mlvp-report -n=auto -sv .

dut:
	$(PICKER) export --autobuild=true $(VSRC_DIR)/$(NAME).v -w $(NAME).fst --sname $(NAME) --tdir picker_out_$(NAME_L) --lang python -e -c --sim verilator
	@cp -r picker_out_$(NAME_L)/UT_$(NAME) .

clean:
	rm -rf UT_$(NAME) picker_out_$(NAME_L) reports *.fst *.fst.hier *.dat
