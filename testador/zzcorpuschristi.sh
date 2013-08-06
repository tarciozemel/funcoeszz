#!/usr/bin/env bash
debug=0
values=1
tests=(
1995	t	15/06/1995
1996	t	06/06/1996
1997	t	29/05/1997
1998	t	11/06/1998
1999	t	03/06/1999
2000	t	22/06/2000
2001	t	14/06/2001
2002	t	30/05/2002
2003	t	19/06/2003
2004	t	10/06/2004
2005	t	26/05/2005
2006	t	15/06/2006
2007	t	07/06/2007
2008	t	22/05/2008
2009	t	11/06/2009
2010	t	03/06/2010

# Erros
01/01/1970	t	"Ano inválido '01/01/1970'"
-2000 		t	"Ano inválido '-2000'"
0 		t	"Ano inválido '0'"
foo 		t	"Ano inválido 'foo'"

# Epoch
1	t	26/05/1
10	t	19/06/10
100	t	11/06/100
1000	t	30/05/1000
1969	t	05/06/1969
)
. _lib