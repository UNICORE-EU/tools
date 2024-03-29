var asciidoc = {  // Namespace.

/////////////////////////////////////////////////////////////////////
// Table Of Contents generator
/////////////////////////////////////////////////////////////////////

/* Author: Mihai Bazon, September 2002
 * http://students.infoiasi.ro/~mishoo
 *
 * Table Of Content generator
 * Version: 0.4
 *
 * Feel free to use this script under the terms of the GNU General Public
 * License, as long as you do not remove or alter this notice.
 */

 /* modified by Troy D. Hanson, September 2006. License: GPL */
 /* modified by Stuart Rackham, 2006, 2009. License: GPL */

// toclevels = 1..4.
toc: function (toclevels) {

  function getText(el) {
    var text = "";
    for (var i = el.firstChild; i != null; i = i.nextSibling) {
      if (i.nodeType == 3 /* Node.TEXT_NODE */) // IE doesn't speak constants.
        text += i.data;
      else if (i.firstChild != null)
        text += getText(i);
    }
    return text;
  }

  function TocEntry(el, text, toclevel) {
    this.element = el;
    this.text = text;
    this.toclevel = toclevel;
  }

  function tocEntries(el, toclevels) {
    var result = new Array;
    var re = new RegExp('[hH]([2-'+(toclevels+1)+'])');
    // Function that scans the DOM tree for header elements (the DOM2
    // nodeIterator API would be a better technique but not supported by all
    // browsers).
    var iterate = function (el) {
      for (var i = el.firstChild; i != null; i = i.nextSibling) {
        if (i.nodeType == 1 /* Node.ELEMENT_NODE */) {
          var mo = re.exec(i.tagName);
          if (mo && (i.getAttribute("class") || i.getAttribute("className")) != "float") {
            result[result.length] = new TocEntry(i, getText(i), mo[1]-1);
          }
          iterate(i);
        }
      }
    }
    iterate(el);
    return result;
  }

  var toc = document.getElementById("toc");
  var entries = tocEntries(document.getElementById("content"), toclevels);
  for (var i = 0; i < entries.length; ++i) {
    var entry = entries[i];
    if (entry.element.id == "")
      entry.element.id = "_toc_" + i;
    var a = document.createElement("a");
    a.href = "#" + entry.element.id;
    a.appendChild(document.createTextNode(entry.text));
    var div = document.createElement("div");
    div.appendChild(a);
    div.className = "toclevel" + entry.toclevel;
    toc.appendChild(div);
  }
  if (entries.length == 0)
    toc.parentNode.removeChild(toc);
},

fixReferences: function () {

  // own implementation of this since it is not supported by all browsers (IE - as usual :)
  function getElementsByClassName(element, class_name)
  {
    var all_obj,ret_obj=new Array(),k=0,teststr;

    if(element.all)all_obj=element.all;
    else if(element.getElementsByTagName && !element.all)
      all_obj=element.getElementsByTagName("*");
    for(var j=0;j<all_obj.length;j++)
    {
      if(all_obj[j].className.indexOf(class_name)!=-1)
      {
        teststr=","+all_obj[j].className.split(" ").join(",")+",";
        if(teststr.indexOf(","+class_name+",")!=-1)
        {
          ret_obj[k]=all_obj[j];
          k++;
        }
      }
    }
    return ret_obj;
  }


  function storeSectionNum(refNames,element) {
    if(element != null)
    {
        var id = element.getAttribute("id");
        if(element.innerHTML.match("^[0-9.]+ .*"))
        {
           var parts = element.innerHTML.split(" ");
           var refName = parts[0];
           if(refName.match("\\.$")==".")
           {
             refName = refName.substr(0,refName.length-1);
           }
           refNames[id] = "Section "+refName;
        }
    }
  }

  function storeImageNum(refNames,imageblock) {
    var id = imageblock.getAttribute("id");
    var element = getElementsByClassName(imageblock,"image-title")[0];
    var match;
    if(element != null)
    {
        if(match = element.innerHTML.match("^\\w+\\s+([0-9.]+).*"))
        {
           var refName = match[1];
           refNames[id] = "Figure "+refName;
        }
    }
  }

  var refNames = new Array();
  var elements = document.getElementsByTagName("h2");
  for (var i = 0; i < elements.length; ++i) {
    storeSectionNum(refNames,elements[i]);
  }

  elements = document.getElementsByTagName("h3");
  for (var i = 0; i < elements.length; ++i) {
    storeSectionNum(refNames,elements[i]);
  }

  elements = document.getElementsByTagName("h4");
  for (var i = 0; i < elements.length; ++i) {
    storeSectionNum(refNames,elements[i]);
  }

  elements = getElementsByClassName(document,"imageblock");
  for (var i = 0; i < elements.length; ++i) {
    storeImageNum(refNames,elements[i]);
  }

  for (var i = 0; i < document.links.length; ++i)
  {
    var link = document.links[i];
    var refName = refNames[link.href.split("#")[1]];
    if(refName != null)
    {
      link.innerHTML=refName;
    }
  }
},

/////////////////////////////////////////////////////////////////////
// Footnotes generator
/////////////////////////////////////////////////////////////////////

/* Based on footnote generation code from:
 * http://www.brandspankingnew.net/archive/2005/07/format_footnote.html
 */

footnotes: function () {
  var cont = document.getElementById("content");
  var noteholder = document.getElementById("footnotes");
  var spans = cont.getElementsByTagName("span");
  var refs = {};
  var n = 0;
  for (i=0; i<spans.length; i++) {
    if (spans[i].className == "footnote") {
      n++;
      // Use [\s\S] in place of . so multi-line matches work.
      // Because JavaScript has no s (dotall) regex flag.
      note = spans[i].innerHTML.match(/\s*\[([\s\S]*)]\s*/)[1];
      noteholder.innerHTML +=
        "<div class='footnote' id='_footnote_" + n + "'>" +
        "<a href='#_footnoteref_" + n + "' title='Return to text'>" +
        n + "</a>. " + note + "</div>";
      spans[i].innerHTML =
        "[<a id='_footnoteref_" + n + "' href='#_footnote_" + n +
        "' title='View footnote' class='footnote'>" + n + "</a>]";
      var id =spans[i].getAttribute("id");
      if (id != null) refs["#"+id] = n;
    }
  }
  if (n == 0)
    noteholder.parentNode.removeChild(noteholder);
  else {
    // Process footnoterefs.
    for (i=0; i<spans.length; i++) {
      if (spans[i].className == "footnoteref") {
        var href = spans[i].getElementsByTagName("a")[0].getAttribute("href");
        href = href.match(/#.*/)[0];  // Because IE return full URL.
        n = refs[href];
        spans[i].innerHTML =
          "[<a href='#_footnote_" + n +
          "' title='View footnote' class='footnote'>" + n + "</a>]";
      }
    }
  }
}

}