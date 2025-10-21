#!/bin/bash

error_exit() {
    echo "Error: $1" >&2
    echo "Usage: $0 DELIVERY" >&2
    echo "          DELIVERY is one of 'e0', 'ei', or 'ef'" >&2
    exit 1
}

[[ $# -ne 1 ]] && error_exit "argument expected"

DIRECTORY=$1

# misc 
/bin/rm -rf $DIRECTORY/**/.project
/bin/rm -rf $DIRECTORY/**/.cproject
/bin/rm -rf $DIRECTORY/**/.cvsignore
/bin/rm -rf $DIRECTORY/**/.gitignore
/bin/rm -rf $DIRECTORY/**/.settings
/bin/rm -rf $DIRECTORY/**/.docsdone
/bin/rm -rf $DIRECTORY/**/.placeholder
/bin/rm -rf $DIRECTORY/**/.classpath
/bin/rm -rf $DIRECTORY/**/*.class
/bin/rm -rf $DIRECTORY/**/*.jar
/bin/rm -rf $DIRECTORY/**/*.xml
/bin/rm -rf $DIRECTORY/**/*.import
/bin/rm -rf $DIRECTORY/**/*.in
/bin/rm -rf $DIRECTORY/**/*.out
/bin/rm -rf $DIRECTORY/**/[Mm]akefile
/bin/rm -rf $DIRECTORY/**/po-uilib*
/bin/rm -rf $DIRECTORY/**/*~

# other
/bin/rm -rf $DIRECTORY/**/examples
/bin/rm -rf $DIRECTORY/**/tests
/bin/rm -rf $DIRECTORY/**/testes

# po-uilib
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/Dialog.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/Display.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/FieldBoolean.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/FieldInteger.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/Field.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/FieldNone.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/FieldOption.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/FieldReal.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/FieldString.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/FormException.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/Form.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/forms/Message.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/InteractionDriver.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/menus/CommandException.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/menus/Command.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/menus/DoOpenMenu.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/menus/Menu.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/menus/Message.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/swing/NewSwingInteraction.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/swing/Prompt.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/swing/SwingDialogForm.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/swing/SwingDialogMenu.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/swing/SwingForm.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/swing/SwingInteraction.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/swing/SwingMenu.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/swing/SwingMessage.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/swing/SwingPanel.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/text/CompositePrintStream.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/text/Message.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/text/Prompt.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/text/Property.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/text/RuntimeEOFException.java
/bin/rm -rf $DIRECTORY/**/pt/tecnico/uilib/text/TextInteraction.java

# from project app

/bin/rm -rf $DIRECTORY/**/bci/app/App.java
/bin/rm -rf $DIRECTORY/**/bci/app/exceptions/BorrowingRuleFailedException.java
/bin/rm -rf $DIRECTORY/**/bci/app/exceptions/FileOpenFailedException.java
/bin/rm -rf $DIRECTORY/**/bci/app/exceptions/Message.java
/bin/rm -rf $DIRECTORY/**/bci/app/exceptions/NoSuchCreatorException.java
/bin/rm -rf $DIRECTORY/**/bci/app/exceptions/NoSuchUserException.java
/bin/rm -rf $DIRECTORY/**/bci/app/exceptions/NoSuchWorkException.java
/bin/rm -rf $DIRECTORY/**/bci/app/exceptions/UserIsActiveException.java
/bin/rm -rf $DIRECTORY/**/bci/app/exceptions/UserRegistrationFailedException.java
/bin/rm -rf $DIRECTORY/**/bci/app/exceptions/WorkNotBorrowedByUserException.java
/bin/rm -rf $DIRECTORY/**/bci/app/main/DoOpenMenuRequests.java
/bin/rm -rf $DIRECTORY/**/bci/app/main/DoOpenMenuUsers.java
/bin/rm -rf $DIRECTORY/**/bci/app/main/DoOpenMenuWorks.java
/bin/rm -rf $DIRECTORY/**/bci/app/main/Label.java
/bin/rm -rf $DIRECTORY/**/bci/app/main/Menu.java
/bin/rm -rf $DIRECTORY/**/bci/app/main/Message.java
/bin/rm -rf $DIRECTORY/**/bci/app/main/Prompt.java
/bin/rm -rf $DIRECTORY/**/bci/app/request/Label.java
/bin/rm -rf $DIRECTORY/**/bci/app/request/Menu.java
/bin/rm -rf $DIRECTORY/**/bci/app/request/Message.java
/bin/rm -rf $DIRECTORY/**/bci/app/request/Prompt.java
/bin/rm -rf $DIRECTORY/**/bci/app/user/Label.java
/bin/rm -rf $DIRECTORY/**/bci/app/user/Menu.java
/bin/rm -rf $DIRECTORY/**/bci/app/user/Message.java
/bin/rm -rf $DIRECTORY/**/bci/app/user/Prompt.java
/bin/rm -rf $DIRECTORY/**/bci/app/work/Label.java
/bin/rm -rf $DIRECTORY/**/bci/app/work/Menu.java
/bin/rm -rf $DIRECTORY/**/bci/app/work/Message.java
/bin/rm -rf $DIRECTORY/**/bci/app/work/Prompt.java

# from project core

/bin/rm -rf $DIRECTORY/**/bci/exceptions/UnavailableFileException.java
/bin/rm -rf $DIRECTORY/**/bci/exceptions/ImportFileException.java
/bin/rm -rf $DIRECTORY/**/bci/exceptions/MissingFileAssociationException.java
/bin/rm -rf $DIRECTORY/**/bci/exceptions/UnrecognizedEntryException.java

# clean CVS Id tags

sed -i 's=\$Id: .* \$==g' $DIRECTORY/**/*.java

