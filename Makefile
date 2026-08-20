.PHONY: all run edit translations-update translations-release

all: translations-release
	pyuic6 uaclient/mainwindow_ui.ui -o uaclient/mainwindow_ui.py
	pyuic6 uaclient/connection_ui.ui -o uaclient/connection_ui.py
	pyuic6 uaclient/applicationcertificate_ui.ui -o uaclient/applicationcertificate_ui.py
	pyside6-rcc uawidgets/resources.qrc -o uawidgets/resources.py
	sed -i 's/from PySide6 import QtCore/from PyQt6 import QtCore/' uawidgets/resources.py

translations-update:
	pylupdate6 uaclient/mainwindow_ui.ui uaclient/connection_ui.ui uaclient/applicationcertificate_ui.ui uaclient/mainwindow.py uaclient/connection_dialog.py uaclient/application_certificate_dialog.py uaclient/graphwidget.py uawidgets/tree_widget.py uawidgets/attrs_widget.py uawidgets/refs_widget.py uawidgets/call_method_dialog.py uawidgets/new_node_dialogs.py -ts uaclient/translations/opcua-client_ko.ts
translations-release:
	pyside6-lrelease -fail-on-invalid -fail-on-unfinished uaclient/translations/opcua-client_ko.ts -qm uaclient/translations/opcua-client_ko.qm

run:
	PYTHONPATH=$(shell pwd)
	python3 app.py
edit:
	qtcreator uaclient/mainwindow_ui.ui
