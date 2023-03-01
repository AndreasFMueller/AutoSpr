
#line 1 "teilbar.c"
/*
 * teilbar.c --- simple ragel example
 *
 * (c) 2023 Prof Dr Andreas Müller
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#line 27 "teilbar.c"



#line 18 "teilbar_fsm.c"
static const char _teilbar_actions[] = {
	0, 1, 0
};

static const char _teilbar_key_offsets[] = {
	0, 0, 2, 4
};

static const char _teilbar_trans_keys[] = {
	48, 49, 48, 49, 48, 49, 0
};

static const char _teilbar_single_lengths[] = {
	0, 2, 2, 2
};

static const char _teilbar_range_lengths[] = {
	0, 0, 0, 0
};

static const char _teilbar_index_offsets[] = {
	0, 0, 3, 6
};

static const char _teilbar_indicies[] = {
	0, 2, 1, 3, 0, 1, 2, 3, 
	1, 0
};

static const char _teilbar_trans_targs[] = {
	2, 0, 3, 1
};

static const char _teilbar_trans_actions[] = {
	0, 0, 0, 0
};

static const char _teilbar_eof_actions[] = {
	0, 0, 0, 1
};

static const int teilbar_start = 3;
static const int teilbar_first_final = 3;
static const int teilbar_error = 0;

static const int teilbar_en_teilbar = 3;


#line 30 "teilbar.c"

int	main(int argc, char *argv[]) {
	int	cs, res = 0;
	int	i;
	for (i = 1; i < argc; i++) {
		res = 0;
		char	*p = argv[i];
		char	*pe = p + strlen(p);
		char	*eof = pe;
		
#line 78 "teilbar_fsm.c"
	{
	cs = teilbar_start;
	}

#line 40 "teilbar.c"
		
#line 85 "teilbar_fsm.c"
	{
	int _klen;
	unsigned int _trans;
	const char *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_keys = _teilbar_trans_keys + _teilbar_key_offsets[cs];
	_trans = _teilbar_index_offsets[cs];

	_klen = _teilbar_single_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( (*p) < *_mid )
				_upper = _mid - 1;
			else if ( (*p) > *_mid )
				_lower = _mid + 1;
			else {
				_trans += (unsigned int)(_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _teilbar_range_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( (*p) < _mid[0] )
				_upper = _mid - 2;
			else if ( (*p) > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += (unsigned int)((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	_trans = _teilbar_indicies[_trans];
	cs = _teilbar_trans_targs[_trans];

	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	const char *__acts = _teilbar_actions + _teilbar_eof_actions[cs];
	unsigned int __nacts = (unsigned int) *__acts++;
	while ( __nacts-- > 0 ) {
		switch ( *__acts++ ) {
	case 0:
#line 12 "teilbar.c"
	{ res = 1; }
	break;
#line 163 "teilbar_fsm.c"
		}
	}
	}

	_out: {}
	}

#line 41 "teilbar.c"
		printf("%s %s\n", argv[i], (res) ? "teilbar" : "nicht teilbar");
	}
	return EXIT_SUCCESS;
}
