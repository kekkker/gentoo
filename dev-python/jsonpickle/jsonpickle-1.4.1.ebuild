# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Python library for serializing any arbitrary object graph into JSON"
HOMEPAGE="https://github.com/jsonpickle/jsonpickle/ https://pypi.org/project/jsonpickle/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"
RESTRICT="!test? ( test )"

# There are optional json backends serializer/deserializers in addition to those selected here
# jsonlib, yajl.
RDEPEND="
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/feedparser[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
"
DEPEND="
	test? ( ${RDEPEND}
		dev-python/pandas[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx "docs/source"

python_test() {
	# An apparent regression in tests
	# https://github.com/jsonpickle/jsonpickle/issues/124
	einfo "testsuite has optional tests for package demjson"
	"${EPYTHON}" tests/runtests.py || die "tests failed with ${EPYTHON}"
}
