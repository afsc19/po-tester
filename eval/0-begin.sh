#!/bin/bash

COURSE_NAME="Programação com Objectos 2025/2026, LEIC-A"
COURSE_LINK_FENIX="https://fenix.tecnico.ulisboa.pt/disciplinas/PO112/2025-2026/1-semestre"
COURSE_LINK_WIKI="https://web.tecnico.ulisboa.pt/~david.matos/w/pt/index.php/Programa%C3%A7%C3%A3o_com_Objectos"
REQUIRED_UML_DELIVERY_FILE="UML-bci-core.pdf"
REPORT_FILE="GLOBAL-REPORT.md"

error_exit() {
    echo "Error: $1" >&2
    echo "Usage: $0 DELIVERY TIMESTAMP" >&2
    echo "          DELIVERY is one of 'e0', 'ei', or 'ef'" >&2
    exit 1
}

[[ $# -ne 2 ]] && error_exit "two arguments are expected"

DELIVERY=$1
TIMESTAMP=$2

case $DELIVERY in
  e0) REFERENCE="Template project" ;;
  ei) REFERENCE="Entrega UML" ;;
  ef) REFERENCE="Entrega Intermédia" ;;
  *) error_exit "bad delivery specification" ;;
esac

cat << EOF > "$REPORT_FILE"
# $COURSE_NAME, Projecto: Daily Run (reference: $REFERENCE)

Full information can be found on the [official Fénix page]($COURSE_LINK_FENIX) ([Projecto]($COURSE_LINK_FENIX/projecto)) or on the [OOP wiki]($COURSE_LINK_WIKI) ([Projecto]($COURSE_LINK_WIKI/Projecto_de_Programa%C3%A7%C3%A3o_com_Objectos)).

Students whose result is **NO DELIVERY** (at each deadline) will be excluded from the course.

EOF

if [ "$DELIVERY" = "e0" ]; then
  cat << EOF >> "$REPORT_FILE"
Students whose result is **UML MISSING** and are missing file **$REQUIRED_UML_DELIVERY_FILE** will be excluded from the course.

"Recipe" for uploading UML reports: [wiki]($COURSE_LINK_WIKI/Projecto_de_Programa%C3%A7%C3%A3o_com_Objectos/Reposit%C3%B3rio_GIT#.22Receita.22_para_a_Entrega_de_Diagramas_UML)

EOF
fi

cat << EOF >> "$REPORT_FILE"
During execution of Java programs, the maximum file size is 1 MB and the maximum execution time is 5s.

Tests for $TIMESTAMP started at $(date)

EOF

# git add "$REPORT_FILE" || true
