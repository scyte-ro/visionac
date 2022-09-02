var obj = Object.defineProperties(new Error, {
    message: {
        get() {
            console.clear();
            fetch(`https://${GetParentResourceName()}/vacnuiblocker`, {
                method: "POST",
                mode: "cors",
                body: JSON.stringify({
                    data: "nuiblocked"
                })
            });
        }
    },
    toString: { value() { (new Error).stack.includes("toString") && console.log("VAC") } }
});
console.log(obj)
