function check() {
    var dropdown1 = document.getElementById("OperationTypeEdit");
    var dropdown2 = document.getElementById("OperationTypeNew");
    if (dropdown1!=null) {
      var current_value1 = dropdown1.options[dropdown1.selectedIndex].value;
      if (current_value1 == "youtube") {
        document.getElementById("youtubeEdit").style.display = "block";
        document.getElementById("attachmentEdit").style.display = "none";
      }
      else {
        document.getElementById("attachmentEdit").style.display = "block";
        document.getElementById("youtubeEdit").style.display = "none";
      }
    }

    if (dropdown2!=null) {
      var current_value2 = dropdown2.options[dropdown2.selectedIndex].value;

      if (current_value2 == "youtube") {
        document.getElementById("youtubeNew").style.display = "block";
        document.getElementById("attachmentNew").style.display = "none";
      }
      else {
        document.getElementById("attachmentNew").style.display = "block";
        document.getElementById("youtubeNew").style.display = "none";
      }
    }
}

check()

function showElement(id) {
  if (id == "newLink") {
    document.getElementById("newLink").style.display = "block"
    document.getElementById("newLinkButton").style.display = "none"
  }
  else if (id == "newAttachment") {
    document.getElementById("newAttachment").style.display = "block"
    document.getElementById("newAttachmentButton").style.display = "none"
  }
  else if (id == "editLink") {
    document.getElementById("editLink").style.display = "block"
    document.getElementById("editLinkButton").style.display = "none"
  }
  else if (id == "editAttachment") {
    document.getElementById("editAttachment").style.display = "block"
    document.getElementById("editAttachmentButton").style.display = "none"
  }
}
