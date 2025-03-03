const jsreport = require('jsreport-proxy')

function beforeRender(req, res) {    
    req.options.pdfUtils = { removeHiddenMarks: false }
}

async function afterRender (req, res) {
    if (req.data.secondRender) {
        return
    }

    const p  = await jsreport.pdfUtils.parse(res.content, true)    
    
    const finalR = await jsreport.render({
        template: {
            name: req.template.name
        },
        data: {
            ...req.data,
            $pdf: p,
            secondRender: true
        }
    })
    res.content = finalR.content
}