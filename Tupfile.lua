tup.rule('$(NETHACK_ROOT)/*.oz', 'ozc -c *.oz -o %o', {'$(NETHACK_ROOT)/binaries/test.elf', '$(NETHACK_ROOT)/binaries/<test>'})
tup.rule({'$(NETHACK_ROOT)/binaries/<test>'}, 'ozengine %<test>')
