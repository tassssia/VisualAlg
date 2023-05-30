import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
Rectangle {
    signal hideMeCliked()
    id: secondDialog
    visible: true
    width: parent.width
    height: parent.height
    anchors.centerIn: parent


    property var values: [45,11,43,42,13,39]
    property var sortSteps: []
    property int currentStepIndex: 0
    Item {
        anchors.fill: parent

        Rectangle {
            id: topRect
            height: 100
            width: parent.width
            color: "#721F1F"
            anchors.top: parent.top

            Text {
                text: "Sorting algorithms"
                font.bold: true
                font.pixelSize: 32
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 35
                color: "white"
            }
        }
        Item {
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.top: topRect.bottom

            Rectangle {
                id: leftRect
                width: 0.8 * parent.width
                height: parent.height
                anchors.left: parent.left

                GridView {
                           width: parent.width
                           height: parent.height - 80
                           cellWidth: parent.width/ listModel.count
                           cellHeight: parent.height - 80
                           model: ListModel {
                               id: listModel
                               ListElement { value:45}
                               ListElement { value: 11 }
                               ListElement { value: 43 }
                               ListElement { value:42 }
                               ListElement { value: 13 }
                               ListElement { value: 39 }
                               //ListElement { value: 13 }
                              // ListElement { value: 4 }
                            //   ListElement { value: 47 }
                             //  ListElement { value: 11 }
                           }

                           delegate: Rectangle {
                               width: parent.width/ listModel.count
                               height: value * 10
                               color: "steelblue"
                               border.color: "black"
                               Text {
                                   text: value
                                   anchors.centerIn: parent
                               }
                           }
                       }
            }
        }
        Item {
            id: rightItem
            width: 0.2 * parent.width
            height: parent.height
            anchors.right: parent.right

            Column {
                anchors.top: parent.top
                anchors.topMargin: 150
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                  TextField {
                     id: inputValue
                    height: 50
                     width: rightItem.width * 0.7
                    placeholderText: "Введіть число"
                     }

          Button {
            id: addButton
            height: 50
            width: rightItem.width * 0.7

            text: "Додати"
            onClicked: {
                var inputNumber = parseInt(inputValue.text)
                if (!isNaN(inputNumber)) {
                    addValue(inputNumber)
                    inputValue.text = ""
                }
            }
        }
          Connections {
                                target: bubbleSort
                                onCallQml: {
                                        values=[]
                                        for (var i = 0; i < steplist.length; i++) {
                                           values.push(steplist[i]);
                                        }
                                        sortSteps.push(values.slice())
                                        updateGridView()
                                        currentStepIndex++
                                  }
                              }

        Button {
            height: 50
            width: rightItem.width * 0.7
            text: "BubbleSort"
            onClicked: {

                arrayIntoQlist(values.slice())
                 bubbleSort.sort()
                currentStepIndex = 0
               console.log( bubbleSort.getComplexity())

            }
        }
        Connections {
                              target: quickSort
                              onCallQml: {
                                      values=[]
                                      for (var i = 0; i < steplist.length; i++) {
                                         values.push(steplist[i]);
                                      }
                                      sortSteps.push(values.slice())
                                      updateGridView()
                                      currentStepIndex++
                                }
                            }
        Button {
            height: 50
            width: rightItem.width * 0.7
            text: "QuickSort"
            onClicked: {
               arrayIntoQlist(values.slice())
                 quickSort.sort()
                currentStepIndex = 0
              // console.log( QuickSort.getComplexity())

            }
        }
        Connections {
                              target: mergeSort
                              onCallQml: {
                                      values=[]
                                      for (var i = 0; i < steplist.length; i++) {
                                         values.push(steplist[i]);
                                      }
                                      sortSteps.push(values.slice())
                                      updateGridView()
                                      currentStepIndex++
                                }
                            }
        Button {
            height: 50
            width: rightItem.width * 0.7
            text: "MergeSort"
            onClicked: {

                arrayIntoQlist(values.slice())
                 mergeSort.sort()

                currentStepIndex = 0
              // console.log(   MergeSort.getComplexity())

            }
        }

        Button {
            height: 50
            width: rightItem.width * 0.7
            text: "Назад"
            onClicked: {
                console.log(currentStepIndex)
                previousStep()
            }
          //  enabled: currentStepIndex > 0
        }


        Button {
            height: 50
            width: rightItem.width * 0.7
            text: "Вперед"
            onClicked: {
                console.log(currentStepIndex)
                nextStep()
            }
           // enabled: currentStepIndex < sortSteps.length - 1
        }
            }

}
        Button {
            id: back
            anchors.bottom: parent.bottom
            text: "Back"
            onClicked: secondDialog.hideMeCliked()
        }
   }

     function arrayIntoQlist(list){
        for (var i=0;i<list.length;i++){
              array.addItem(list[i] )
             }
        }

    function addValue(number) {
        values.push(number)
        listModel.append({ value: number })
    }


    function previousStep() {
       // if (currentStepIndex > 0) {
            currentStepIndex--
            updateGridView()
       // }
    }

    function nextStep() {
        if (currentStepIndex < sortSteps.length - 1) {
            currentStepIndex++
            updateGridView()
        }
    }

    function updateGridView() {
        listModel.clear()
        var stepValues = sortSteps[currentStepIndex]
        for (var i = 0; i < stepValues.length; i++) {
            listModel.append({ value: stepValues[i] })
        }
    }
}

