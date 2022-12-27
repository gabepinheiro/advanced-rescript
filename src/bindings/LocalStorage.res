type t

@val external localStorage: t = "localStorage"
@send external getItem: (t, ~key: string) => Js.Null.t<string> = "getItem"
@send external setItem: (t, ~key: string, ~value: string) => unit = "setItem"

//comment
