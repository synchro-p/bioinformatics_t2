

process sayHello {
  output:
    stdout

  "echo Hello World!"
}

workflow {
  sayHello | view { it.trim() }
}
