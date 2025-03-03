const jsreport = require('jsreport-proxy')
const headings = []


function now() {
    return new Date().toLocaleDateString()
}

function nowPlus20Days() {
    var date = new Date()
    date.setDate(date.getDate() + 20);
    return date.toLocaleDateString();
}
function toJSON(data) {
    return JSON.stringify(data);
}
function total(items) {
    var sum = 0
    items.forEach(function (i) {
        console.log('Calculating item ' + i.name + '; you should see this message in debug run')
        sum += i.price
    })
    return sum
}

function mod(value, modulus) {
    return value % modulus === 0;
}

function getCategoryStatus(status) {
  switch (status) {
    case 'consistent':
      return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M9 19L3.5 13.5L5.5 11.5L9 15L18.5 5.5L20.5 7.5L9 19Z"/></svg>`;
    case 'added':
      return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M19 13H13V19H11V13H5V11H11V5H13V11H19V13Z"/></svg>`;
    case 'removed':
      return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M19 13H5V11H19V13Z"/></svg>`;
    default:
      return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zM12 19c-3.87 0-7-3.13-7-7s3.13-7 7-7 7 3.13 7 7-3.13 7-7 7z"/></svg>`; // Default icon if status is undefined
  }
}


function heading(h, opts) {
    const { id, content, parent, class: className, style } = opts.hash;
    headings.push({ id, content, parent });

    const classAttr = className ? ` class='${className}'` : '';
    const styleAttr = style ? ` style='${style}'` : '';

    const headingHtml = `<${h} id='${id}'${classAttr}${styleAttr}>${content}</${h}>`;

    const hiddenMark = pdfAddPageItem.call(this, {            
        ...opts,
        hash: { headingId: id }
    });

    return headingHtml + hiddenMark;
}


async function toc(opts) {
    // we need to postpone the toc printing till all the headings are registered
    // using heading helper
    await jsreport.templatingEngines.waitForAsyncHelpers()
    let res = ''
    for (let { id, content, parent } of headings) {
        res += opts.fn({
            ...this,            
            pageNumber: getPageNumber(id, opts),
            content,
            parent,
            id
        })
    }

    return res
}

function getPageNumber(id, opts) {
    if (!opts.data.root.$pdf) {        
        return 'NA'
    }

    for (let i = 0; i < opts.data.root.$pdf.pages.length; i++) {
        const item = opts.data.root.$pdf.pages[i].items.find(item => item.headingId === id)

        if (item) {
            return i + 1
        }
    }
    return 'NOT FOUND'
}