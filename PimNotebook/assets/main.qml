/* Copyright (c) 2012 Research In Motion Limited.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import bb.cascades 1.0

NavigationPane {
    id: navigationPane

    onPopTransitionEnded: page.destroy()

    // The main page
    Page {
        Container {
            layout: DockLayout {}

            // The background image
            ImageView {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill

                imageSource: "asset:///images/background.png"
            }

            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill

                leftPadding: 30
                topPadding: 30
                rightPadding: 30
                bottomPadding: 30

//! [0]
                // The note list filter input
                TextField {
                    hintText: qsTr ("Filter by...")

                    onTextChanging: _noteBook.filter = text
                }
//! [0]

//! [1]
                // The list view with all notes
                ListView {
                    dataModel: _noteBook.model

                    listItemComponents: ListItemComponent {
                        type: "item"

                        StandardListItem {
                            title: ListItemData.title
                            description: ListItemData.status
                        }
                    }

                    onTriggered: {
                        clearSelection()
                        select(indexPath)

                        _noteBook.setCurrentNote(indexPath)

                        _noteBook.viewNote();
                        navigationPane.push(noteViewer.createObject())
                    }
                }
//! [1]
            }
        }

//! [2]
        actions: [
            ActionItem {
                title: qsTr ("New")
                imageSource: "asset:///images/action_addnote.png"
                ActionBar.placement: ActionBarPlacement.OnBar

                onTriggered: {
                    _noteBook.createNote()
                    navigationPane.push(noteEditor.createObject())
                }
            }
        ]
//! [2]
    }

//! [3]
    attachedObjects: [
        ComponentDefinition {
            id: noteEditor
            source: "NoteEditor.qml"
        },
        ComponentDefinition {
            id: noteViewer
            source: "NoteViewer.qml"
        }
    ]
//! [3]
}
