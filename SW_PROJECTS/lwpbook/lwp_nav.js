
// Time-stamp: "2007-04-16 02:31:52 AKDT sburke@cpan.org"

var Contents_Order = [
	'index', "Perl & LWP",

	'intro',  "Introduction to the 2007 online edition",

	'foreword', "Foreword (by Gisle Aas)",

	'ch00_01', "Preface",
	'ch00_02', "Structure of This Book",
	'ch00_03', "Order of Chapters",
	'ch00_04', "Important Standards Documents",
	'ch00_05', "Conventions Used in This Book",
	'ch00_06', "Comments & Questions",
	'ch00_07', "Acknowledgments",

	'ch01_01', "Introduction to Web Automation",
	'ch01_02', "History of LWP",
	'ch01_03', "Installing LWP",
	'ch01_04', "Words of Caution",
	'ch01_05', "LWP in Action",
	'ch02_01', "Web Basics",
	'ch02_02', "An HTTP Transaction",
	'ch02_03', "LWP::Simple",
	'ch02_04', "Fetching Documents Without LWP::Simple",
	'ch02_05', "Example: AltaVista",
	'ch02_06', "HTTP POST",
	'ch02_07', "Example: Babelfish",
	'ch03_01', "The LWP Class Model",
	'ch03_02', "Programming with LWP Classes",
	'ch03_03', "Inside the do_GET and do_POST Functions",
	'ch03_04', "User Agents",
	'ch03_05', "HTTP::Response Objects",
	'ch03_06', "LWP Classes: Behind the Scenes",
	'ch04_01', "URLs",
	'ch04_02', "Relative URLs",
	'ch04_03', "Converting Absolute URLs to Relative",
	'ch04_04', "Converting Relative URLs to Absolute",
	'ch05_01', "Forms",
	'ch05_02', "LWP and GET Requests",
	'ch05_03', "Automating Form Analysis",
	'ch05_04', "Idiosyncrasies of HTML Forms",
	'ch05_05', "POST Example: License Plates",
	'ch05_06', "POST Example: ABEBooks.com",
	'ch05_07', "File Uploads",
	'ch05_08', "Limits on Forms",
	'ch06_01', "Simple HTML Processing with Regular Expressions",
	'ch06_02', "Regular Expression Techniques",
	'ch06_03', "Troubleshooting",
	'ch06_04', "When Regular Expressions Aren't Enough",
	'ch06_05', "Example: Extracting Links from a Bookmark File",
	'ch06_06', "Example: Extracting Links from Arbitrary HTML",
	'ch06_07', "Example: Extracting Temperatures from Weather Underground",
	'ch07_01', "HTML Processing with Tokens",
	'ch07_02', "Basic HTML::TokeParser Use",
	'ch07_03', "Individual Tokens",
	'ch07_04', "Token Sequences",
	'ch07_05', "More HTML::TokeParser Methods",
	'ch07_06', "Using Extracted Text",
	'ch08_01', "Tokenizing Walkthrough",
	'ch08_02', "Getting the Data",
	'ch08_03', "Inspecting the HTML",
	'ch08_04', "First Code",
	'ch08_05', "Narrowing In",
	'ch08_06', "Rewrite for Features",
	'ch08_07', "Alternatives",
	'ch09_01', "HTML Processing with Trees",
	'ch09_02', "HTML::TreeBuilder",
	'ch09_03', "Processing",
	'ch09_04', "Example: BBC News",
	'ch09_05', "Example: Fresh Air",
	'ch10_01', "Modifying HTML with Trees",
	'ch10_02', "Deleting Images",
	'ch10_03', "Detaching and Reattaching",
	'ch10_04', "Attaching in Another Tree",
	'ch10_05', "Creating New Elements",
	'ch11_01', "Cookies, Authentication, and Advanced Requests",
	'ch11_02', "Adding Extra Request Header Lines",
	'ch11_03', "Authentication",
	'ch11_04', "An HTTP Authentication Example:The Unicode Mailing Archive",
	'ch12_01', "Spiders",
	'ch12_02', "A User Agent for Robots",
	'ch12_03', "Example: A Link-Checking Spider",
	'ch12_04', "Ideas for Further Expansion",


	'appa_01', "LWP Modules",
	'appb_01', "HTTP Status Codes",
	'appb_02', "200s: Successful",
	'appb_03', "300s: Redirection",
	'appb_04', "400s: Client Errors",
	'appb_05', "500s: Server Errors",
	'appc_01', "Common MIME Types",
	'appd_01', "Language Tags",
	'appe_01', "Common Content Encodings",
	'appf_01', "ASCII Table",
	'appg_01', "User's View of Object-Oriented Modules",
	'appg_02', "Modules and Their Functional Interfaces",
	'appg_03', "Modules with Object-Oriented Interfaces",
	'appg_04', "What Can You Do with Objects?",
	'appg_05', "What's in an Object?",
	'appg_06', "What Is an Object Value?",
	'appg_07', "So Why Do Some Modules Use Objects?",
	'appg_08', "The Gory Details",

	'colophon', "Colophon",
	'copyrght', "Copyright",

	'i-index', "Perl & LWP: Index",
	'i-idx_0', "Index: Symbols & Numbers",
	'i-idx_a', "Index: A",
	'i-idx_b', "Index: B",
	'i-idx_c', "Index: C",
	'i-idx_d', "Index: D",
	'i-idx_e', "Index: E",
	'i-idx_f', "Index: F",
	'i-idx_g', "Index: G",
	'i-idx_h', "Index: H",
	'i-idx_i', "Index: I",
	'i-idx_j', "Index: J",
	'i-idx_k', "Index: K",
	'i-idx_l', "Index: L",
	'i-idx_m', "Index: M",
	'i-idx_n', "Index: N",
	'i-idx_o', "Index: O",
	'i-idx_p', "Index: P",
	'i-idx_q', "Index: Q",
	'i-idx_r', "Index: R",
	'i-idx_s', "Index: S",
	'i-idx_t', "Index: T",
	'i-idx_u', "Index: U",
	'i-idx_v', "Index: V",
	'i-idx_w', "Index: W",
	'i-idx_x', "Index: X",
	'i-idx_y', "Index: Y",
	'i-idx_z', "Index: Z"
];
//======================================================================

if(window.lwp_pageid) {
  init_page(window.lwp_pageid);
} else {
  window.status = "LWP book nav error: Couldn't find page ID!";
}

//======================================================================

function pid2url (pid) {
  var url = pid.toString().replace(/^i-/,"") + ".htm";

  if( pid_is_indexy( lwp_pageid || '') ) {
    if( pid_is_indexy(pid) ) {
      ; // we're both in ./index
    } else {
      url = "../" + url;
    }
  } else {
    if( pid_is_indexy(pid) ) {
      url = "index/" + url;
    } else {
      ; // we're both not in ./index
    }
  }

  url = url.replace( /\bindex\.htm$/, 'index.html' );
  return url;
}

function pid_is_chapter (pid) {
  //if( (/^i-/).test(pid) ) return false;
  if( ( /_01$/ ).test(pid) ) return true;
  if( ( /_/    ).test(pid) ) return false;
  return true;
}

function pid_is_indexy (pid) {
  return( (/^i-/).test(pid) );
}

//======================================================================

var Prev_url, Prev_title, Up_url, Up_title, Next_url, Next_title;
var Next_is_chapter;
var Am_indexy, Root;

function init_pointers (page_pid) {
  var prev_id, prev_title, prev_chapter_id, prev_chapter_title;

  Am_indexy  = pid_is_indexy(page_pid);
  Root       = Am_indexy ? "../" : "./";
  Up_url     = Root + "index.html";
  Up_title   = "Table of Contents";
  Next_is_chapter = false;

  for(var i = 0; i < Contents_Order.length; i+= 2) {
    var this_pid   = Contents_Order[i  ];
    var this_title = Contents_Order[i+1];
    var am_chapter = pid_is_chapter(this_pid);
    if(this_pid == page_pid) {
      //alert("I'm " + page_pid + " = @" + i.toString());
      if(i == Contents_Order.length - 2) {
	;// special case: last page.
      } else {
	Next_is_chapter = pid_is_chapter(Contents_Order[i+2]);
	Next_url   = pid2url( Contents_Order[i+2] );
	Next_title =          Contents_Order[i+3]  ;
      }
      if(prev_id) {
        Prev_url   = pid2url( prev_id );
        Prev_title =          prev_title;
      }
      if(!am_chapter) {
	Up_url     = pid2url( prev_chapter_id );
	Up_title   =          prev_chapter_title;
      }
      break;
    } else {
      ; // anything special to do?
    }
    prev_id    = this_pid;
    prev_title = this_title;
    if(am_chapter) {
      prev_chapter_id    = this_pid;
      prev_chapter_title = this_title;
    }
  }
  return;
}

//======================================================================

function init_page (pid) {
  init_pointers(pid);
  init_head();
  if(pid != "index") make_top_navbar();
  return;
}

function init_head () {
  var head;
  var u = "favicon.png";
  var atts =  { 'rel':'icon', 'type': "image/png"};

  if( document.getElementsByTagName ) { // DOM
    head = document.getElementsByTagName('head').item(0);
  } else if ( document.all ) { // MSIE horror
    head = document.all['head'];
    u = 'favicon.ico';
    atts['type'] = 'image/vnd.microsoft.icon';
  } else {
    return;
  }
  atts['href'] = Root + u;
  
  graft(head, ['link', atts]);

  /*  Too flaky just now:
      and if we do put this in, make a cookie persist it across pages.
  graft(head, ['link', {
    'rel':"alternate stylesheet", 'type':"text/css",
    'title': "white-on-black",
    'href': (Root + "lwp_bw.css") }
  ]);
  */

  return;
}

function _button (parent, myclass, desc, url, key, text) {
  if(url) {
    var atts = { 'href': url };
    if(key) {
      atts.accesskey = key;
      atts.title = "alt-" + key +
	" or click, to go to this " + desc + " section";
    } else {
      atts.title =
  	    "click to go to this " + desc + " section";
    }
    parent.push( ['td.' + myclass, ['a', atts, text ] ] );

  } else {
    parent.push( ['td.' + myclass+ '.blank'] );
  }
  return;
}


function make_top_navbar () {

  if(Am_indexy) return;

  var div = ["tr"];
  if( Prev_url && Prev_url == Up_url)  Prev_url = '';

  _button(div, 'prevlink', 'previous', Prev_url, 'p',  Prev_title );
  _button(div,   'uplink', 'higher'  , Up_url  , 'u',  Up_title   );
  _button(div, 'nextlink', 'next'    , Next_url, 'n',  Next_title );
  if(div.length > 1)
    graft( document.body, ['table.navbar.topnavbar', ['tbody', div]] );
  return;
}

//======================================================================

function make_bottom_navbar () {
  var div = ["p.morelink"];

  if(Am_indexy) return;

  if(Next_url) {
    if( Next_is_chapter ) {
      div.push( "The next chapter is: " );
      div.push( ['a', {'href': Next_url}, Next_title] );
      div.push( ['br'] );
      div.push( "or go up to " );
      div.push( ['a', {'href': "index.html"}, "the Table of Contents"] );
      
    } else {
      div.push( "Continue to section: " );
      div.push( ['a', {'href': Next_url}, Next_title] );
    }
  } else {
    graft( document.body, ['h3.the_end', "The End"] );
  }

  if(div.length > 1) graft( document.body, div );
  return;
}
//======================================================================

function make_bottom_lastmod () {
  if(!window.LastUpdate) return;
  graft( document.body, ["p.morelink", "Last update: " + LastUpdate]);
  return;  
}

//======================================================================

function endpage () {
  // do anything?  Add stylesheets?

  if(!window.lwp_pageid) return;
  if(window.lwp_pageid == "index") {
    make_bottom_lastmod();
  } else {
    make_bottom_navbar();
  }
  return true;
}


//======================================================================
// Library functions of mine ...

function complaining () {
  var _ = [];
  for(var i = 0; i < arguments.length; i++) { _.push(arguments[i]) }
  _ = _.join("");
  if(! _.length) out = "Unknown error!?!";
  void alert(_);
  return new Error(_,_);
}

function id (name,doc) { // find element with the given ID, else exception.
  var object = id_try(name,doc);
  if( ! object ) throw complaining("Failed to find element with id='"
   + name + "' in " + (doc || document).location );
  return object;
}

function id_try (name,doc) {
  var object = (doc || document).getElementById(name);
  return object;
}

function graft (parent, t, doc) {
  // graft( somenode, [ "I like ", ['em', { 'class':"stuff" },"stuff"], " oboy!"] )
  //if(!doc) doc = parent.ownerDocument ? parent.ownerDocument : document;
  doc = (doc || parent.ownerDocument || document);

  var e;

  if(t == undefined) {
    if(parent == undefined) throw complaining("Can't graft an undefined value");

  } else if(t.constructor == String) {
    e = doc.createTextNode( t );

  } else if(t.length == 0) {
    e = doc.createElement( "span" );
    e.setAttribute( "class", "fromEmptyLOL" );

  } else {
    for(var i = 0; i < t.length; i++) {
      if( i == 0 && t[i].constructor == String ) {
	var snared;
        snared = t[i].match( /^([a-z][a-z0-9]*)\.([^\s]+)$/i );
        if( snared ) {
          e = doc.createElement(   snared[1] );
          e.setAttribute( 'class', snared[2].replace(/\./g, " "));
          continue;
        }
        snared = t[i].match( /^([a-z][a-z0-9]*)$/i );
        if( snared ) {
          e = doc.createElement(   snared[1] );  // but no class
          continue;
        }

        // Otherwise:
        e = doc.createElement( "span" );
        e.setAttribute( "class", "namelessFromLOL" );
      }

      if( t[i] == undefined ) {
        throw complaining("Can't graft an undefined value in a list!");
      } else if( t[i].constructor == String || t[i].constructor == Array ) {
        graft( e, t[i], doc );
      } else if( t[i].constructor == Number ) {
        graft( e, t[i].toString(), doc );
      } else if( t[i].constructor == Object ) {
        // turn this hash's properties:values into attributes of this element
        for(var k in t[i])  e.setAttribute( k, t[i][k] );
      } else {
        // TODO: make it accept already-made DOM nodes?  by checking "nodeType" in i?
        throw complaining( "Object " + t[i] + " is inscrutable as an graft arglet." );
      }
    }
  }
  
  parent.appendChild( e );
  return e;
}

//======================================================================
