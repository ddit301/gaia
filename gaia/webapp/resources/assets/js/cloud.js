/**
 * <pre>
 * 
 * </pre>
 * @author Robin
 * @since 2021. 5. 27
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier        Modification
 * --------     --------    ----------------------
 * 2021. 5. 27      Robin      Initial Commit
 * Copyright (c) 2021 by Team SEED All right reserved
 * </pre>
 */

const data = [{
  'folder': true,
  'title': 'Books',
  'children': [{
    'title': 'Brain-Friendly Guide.pdf'
  },
  {
    'folder': true,
    'title': 'Elisabeth Robson',
    'children': [{
      'title': 'Head First HTML and CSS.pdf'
    },
    {
      'title': 'HTML5 Programming.pdf'
    }]
  },
  {
    'folder': true,
    'title': 'Kyle Simpson',
    'children': [{
      'title': `You Don't Know JS.pdf`
    },
    {
      'folder': true,
      'title': 'Deep JavaScript Foundations',
      'children': [{
        'title': 'Introduction.mp4'
      },
      {
        'title': 'Types.mp4'
      },
      {
        'title': 'Coercion.mp4'
      }]
    }]
  }
  ]
},
{
  'folder': true,
  'title': 'Soft',
  'children': [{
    'folder': true,
    'title': 'NVIDIA',
    'children': null
  },
  {
    'title': 'nvm-setup.exe'
  },
  {
    'title': 'node.exe'
  }]
},
{
  'folder': true,
  'title': 'Downloads',
  'children': [{
    'folder': true,
    'title': 'Sublime',
    'children': null
  },
  {
    'title': 'RunJS-Setup.exe'
  }
  ]
},
{
  'title': 'credentials.txt'
}
];

const mini_map = document.getElementById('lnb_tree');
const CODE = 13;
let menuBox = null;
let isFileMenuDisplayed = false;
let isRenameMode = false;
let menuActionTarget = null;
let inputField = null;
const CONTEXT_MENU_ITEMS = [{
  text: '잘라내기',
  action: deleteItem
},
{
  text: '복사하기',
  action: deleteItem
},
{
  text: '이동하기',
  action: deleteItem
},
{
  text: '삭제하기',
  action: deleteItem
},
{
  text: '이름 변경하기',
  action: renameItem
},
{
  text: '속성 확인하기',
  action: deleteItem
},
{
  text: '다운로드',
  action: deleteItem
}];


(function () {
  let target = '#thumb_list div';
  let mode = false;
  let startX = 0;
  let startY = 0;
  let left, top, width, height;
  let $focused_thumb = $(".focused_thumb");
  $(document).on("mousedown", function (e) {
    mode = true;
    startX = e.clientX;
    startY = e.clientY;
    width = height = 0;
    $focused_thumb.show();
    rangeSelect(target, 0, 0, 0, 0, function () {
      $(this).removeClass('highlight');
    });
  }).on('mouseup', function (e) {
    mode = false;
    $focused_thumb.hide();
    $focused_thumb.css("width", 0);
    $focused_thumb.css('height', 0);
    rangeSelect(target, left, top, left + width, top + height, function (include) {
      if (include)
        $(this).addClass('highlight');
      else
        $(this).removeClass('highlight');
    });
  }).on('mousemove', function (e) {
    if (!mode) {
      return;
    }
    let x = e.clientX;
    let y = e.clientY;
    width = Math.max(x - startX, startX - x);
    left = Math.min(startX, x);
    $focused_thumb.css('left', left);
    $focused_thumb.css("width", width);
    height = Math.max(y - startY, startY - y);
    top = Math.min(startY, y);
    $focused_thumb.css('top', top);
    $focused_thumb.css('height', height);
  });
  function rangeSelect(selector, x1, y1, x2, y2, cb) {
    $(selector).each(function () {
      let $this = $(this);
      let offset = $this.offset();
      let x = offset.left;
      let y = offset.top;
      let w = $this.width();
      let h = $this.height();
      cb.call(this, x >= x1 && y >= y1 && x + w <= x2 && y + h <= y2);
    });
  }
})();





function deleteItem() {
  let nodeToDelete = menuActionTarget.parentNode;
  let parentToCheck = nodeToDelete.parentNode;

  nodeToDelete.remove();

  if (!parentToCheck.hasChildNodes()) {
    createEmptyItem(parentToCheck);
  }

  menuActionTarget = null;
  contextMenuHide();
}

function renameItem() {
  isRenameMode = true;
  contextMenuHide();
  menuActionTarget.setAttribute('contenteditable', 'true');
  menuActionTarget.focus();

  let end = 0;

  const selection = window.getSelection();
  const range = document.createRange();
  const textToEdit = menuActionTarget.firstChild;

  if (textToEdit.nodeValue.indexOf('.') > 0) {
    end = textToEdit.nodeValue.indexOf('.');
  } else {
    end = textToEdit.nodeValue.length;
  }

  range.setStart(textToEdit, 0);
  range.setEnd(textToEdit, end);
  selection.removeAllRanges();
  selection.addRange(range)

  menuActionTarget.addEventListener('keydown', (event) => {
    if (event.keyCode === CODE) {
      disableRenameMode(event, menuActionTarget);
    }
  })
}

///////////////////////////////////

function createListElement(lnb_tree) {
  let listElement = document.createElement('ul');
  lnb_tree.appendChild(listElement);
  return listElement;
}

function createListItem(lnb_tree, title, isFolder) {
  let listItem = document.createElement('li');
  let spanItem = document.createElement('span');
  spanItem.innerText += title;
  listItem.appendChild(spanItem);

  if (isFolder) {
    spanItem.classList.add('folder');
    spanItem.classList.add('folder_collapsed');
    spanItem.addEventListener('click', (event) => folderStateToggle(event));
  } else {
    spanItem.classList.add('file');
  }

  spanItem.addEventListener('click', (event) => removeStaticHighlihght(event, menuActionTarget));
  spanItem.addEventListener('contextmenu', (event) => removeStaticHighlihght(event, menuActionTarget));
  spanItem.addEventListener('blur', disableRenameMode);
  spanItem.addEventListener('contextmenu', fileMenuShow);
  addHoverEffect(spanItem);
  lnb_tree.appendChild(listItem);
  return listItem;
}

function createEmptyItem(lnb_tree) {
  let emptyList = createListElement(lnb_tree);
  emptyList.classList.add('empty');
  let emptyItem = document.createElement('li');
  emptyItem.innerText += 'Folder is empty';
  emptyList.appendChild(emptyItem);
}

function addHoverEffect(item) {
  item.addEventListener('mouseenter', (event) => {
    if (!isFileMenuDisplayed && !isRenameMode) {
      event.target.classList.add('highlighted');
      event.stopPropagation();
    }
  })

  item.addEventListener('mouseout', (event) => {
    if (!isFileMenuDisplayed && !isRenameMode) {
      event.target.classList.remove('highlighted');
      event.stopPropagation();
    }
  })
}

function folderStateToggle(event) {
  if (event.target.matches('span.folder')) {
    event.target.classList.toggle('folder_collapsed');
  }
}

function removeStaticHighlihght(event, previousActionTarget) {
  if (previousActionTarget && previousActionTarget.classList.contains('highlighted')) {
    previousActionTarget.classList.remove('highlighted');
  }
  event.target.classList.add('highlighted');
}

function createContextMenu(items) {
  const body = document.querySelector('body');
  let contextMenu = document.createElement('div');
  contextMenu.className = 'folder-menu';
  for (let item of items) {
    let menuItem = document.createElement('div');
    menuItem.innerText += item.text;
    menuItem.className = 'folder-menu-item';
    menuItem.addEventListener('click', item.action)
    contextMenu.appendChild(menuItem);
  }
  body.appendChild(contextMenu);
}

function fileMenuShow(event) {
  const PADDING = 5;
  let left = event.clientX;
  let top = event.clientY;
  menuBox = document.querySelector('.folder-menu');
  menuBox.style.left = left + PADDING + 'px';
  menuBox.style.top = top - PADDING + 'px';
  menuBox.style.display = 'block';
  event.target.focus();
  event.preventDefault();
  isFileMenuDisplayed = true;
  menuActionTarget = event.target;
  //////////////////////////////////////////
  if (!menuActionTarget.matches('span.folder') && !menuActionTarget.matches('span.file')) {
    menuBox.style.pointerEvents = 'none';
  } else {
    menuBox.style.pointerEvents = 'auto';
  }
}

function contextMenuHide() {
  if (isFileMenuDisplayed) {
    menuBox.style.display = 'none';
    isFileMenuDisplayed = false;
    if (menuActionTarget && !isRenameMode) {
      menuActionTarget.classList.remove('highlighted');
    }
  }
}

function disableRenameMode(event) {
  if (isRenameMode && !event.target.matches('div.folder-menu-item')) {
    isRenameMode = false;
    menuActionTarget.removeAttribute('contenteditable');
    menuActionTarget.classList.remove('highlighted');
  }
}

function buildHTMLTree(data, mini_map) {
  let list = createListElement(mini_map);
  for (let node of data) {
    let isEmptyFolder = node.folder && !node.children;
    let item = createListItem(list, node.title, node.folder);

    if (node.children) {
      buildHTMLTree(node.children, item);
    } else if (isEmptyFolder) {
      createEmptyItem(item);
    }
  }
}

createContextMenu(CONTEXT_MENU_ITEMS);
buildHTMLTree(data, mini_map);

window.addEventListener('click', contextMenuHide);
window.addEventListener('click', disableRenameMode);
mini_map.addEventListener('contextmenu', fileMenuShow);
