set -q RUBY_CONFIGURE_OPTS; or set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@3)"
set -q RUBY_TCP_NO_FAST_FALLBACK; or set -gx RUBY_TCP_NO_FAST_FALLBACK 1
