module Hello = {
  let a = "Hi, there"
  let b = "Not hi there"
  let getB = () => b
}

module type Greeting = {
  let a: string
  let getB: unit => string
}

let myHello = module(Hello: Greeting)

module HelloBack = unpack(myHello: Greeting)

/* let sayHello = hello => { */
/* module Hello = unpack(hello: Greeting) */
/* Js.log(Hello.a) */
/* Js.log(Hello.getB()) */
/* } */

let sayHello = (module(Hello: Greeting)) => {
  Js.log(Hello.a)
  Js.log(Hello.getB())
}

sayHello(myHello)
