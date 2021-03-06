# ----------------------------------------------------------------------------
# Mostra a classificação e jogos da Copa de Mundo.
# Opções:
#  <fase>: Mostra jogos da fase selecionada
#
# Obs.: Na fase de grupos pode filtrar por mostrar um grupo específico.
#       Pode-se escolher exibir apenas a classificação dos grupos.
#       Pode-se escolher exibir os jogos de todas as fases e grupos.
#
# As fases podem ser:
#  grupos
#  oitavas
#  quartas
#  semi, semi-final
#  final
#
# Os grupos podem ser qualqer letra entre A e H, inclusive minúscula
#
# Sem argumento mostra tudo (fases, grupos, classificação e jogos).
#
# Nomenclatura na fas de grupos:
#	PG  - Pontos Ganhos
#	J   - Jogos
#	V   - Vitórias
#	E   - Empates
#	D   - Derrotas
#	GP  - Gols Pró
#	GC  - Gols Contra
#	SG  - Saldo de Gols
#	(%) - Aproveitamento (pontos)
#
# Uso: zzcopa [fase] [grupo] [classificacao|classificação] [jogos]
# Ex.: zzcopa
#      zzcopa A             # Classificação e jogos do grupo A
#      zzcopa oitava        # Todos os jogos das oitavas de final
#      zzcopa classificação # Classificação de todos os grupos.
#      zzcopa jogos         # Todos os jogos, sem a classificação.
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-12-07
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzcopa ()
{
	zzzz -h copa "$1" && return

	local url="http://oglobo.globo.com/esportes/tabela-copa-do-mundo-2014"
	local sed_ini="^Grupo A"
	local sed_fim="Fornecido por Tabela Fácil"
	local letra

	case "$1" in
	[Gg]rupo | [Gg]rupos)
		sed_fim="^Oitavas de Final"
	;;
	[Oo]itava | [Oo]itavas)
		sed_ini="^Oitavas de Final"
		sed_fim="^Quartas de Final"
	;;
	[Qq]uarta | [Qq]uartas)
		sed_ini="^Quartas de Final"
		sed_fim="^SemiFinal"
	;;
	[Ss]emi-final | [Ss]emi)
		sed_ini="^SemiFinal"
		sed_fim="^Final"
	;;
	[Ff]inal)
		sed_ini="^Final"
	;;
	[a-hA-H])
		letra=$(echo "$1" | tr '[a-h]' '[A-H]')
		sed_ini="^Grupo $letra"
		[ "$letra" = "H" ] && sed_fim="^Oitavas de Final" || sed_fim="^Grupo [^${letra}]"
	;;
	[Cc]lassifica[cç][aã]o)
		sed_ini="^Grupo "
		sed_fim="^Jogos"
	;;
	[Jj]ogo | [Jj]ogos)
		sed_ini="^Jogos"
		sed_fim="^Grupo "
	;;
	esac

	$ZZWWWDUMP "$url" | sed -n "/$sed_ini/,/$sed_fim/p" | sed "/$sed_fim/d;s/ *Links//" |
	awk '
		no_print=0
		/Fornecido por Tabela Fácil/ { exit }
		/^Grupo [A-H]/               { print;getline;getline; no_print=1 }
		/^Classificação/             { print;getline;getline; no_print=1 }
		/^Jogos/                     { print;getline;getline; no_print=1 }
		/^Oitavas de Final/          { print;getline;getline; no_print=1 }
		/^Quartas de Final/          { print;getline;getline; no_print=1 }
		/^SemiFinal/                 { print;getline;getline; no_print=1 }
		/^Final/                     { print;getline;getline; no_print=1 }
		{ if (no_print ==0) print }
		'
}
