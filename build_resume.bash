#!/usr/bin/env bash
set -eux

root_path="$(cd "$(dirname "$0")" ; pwd)"
xp_path="$root_path/experience"
target_path="$root_path/target"

###############
# Perl part
###############

perl_is_installed(){ # name
    typeset module_name="$1"
    perl -e "use $module_name;" >/dev/null 2>&1
}

perl_insall_module(){ # name
    typeset module_name="$1"
    perl -MCPAN -e 'install $module_name'
}

if ! perl_is_installed "HTML::Entities"; then
    perl_insall_module "HTML::Entities"
fi

perl_escape_entities(){ # >in <out
    perl -e "use strict; use warnings; \
             use HTML::Entities; \
             while(my \$input = <>){ \
                 print encode_entities(\$input); \
             }"
}


mkdir -p "$target_path"
{
	cat header.md
	cat qualification.md
	cat education.md
	
	cat experience_header.md
	ls "$xp_path" | sort | while read l; do
		cat "$xp_path/$l"
	done

} | perl_escape_entities > "$target_path/resume.md"


