tup.rule
({'$(NETHACK_ROOT)/List.oz', '$(NETHACK_ROOT)/test.oz'},
'ozc -c $(NETHACK_ROOT)/test.oz -o %o', {'$(NETHACK_ROOT)/binaries/test.elf', '$(NETHACK_ROOT)/binaries/<test>'})
tup.rule({'$(NETHACK_ROOT)/binaries/<test>'}, 'ozengine %<test>')
