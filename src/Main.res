let root = ReactDOM.querySelector("#root")

switch root {
| Some(element) =>
  ReactDOM.render(
    <React.StrictMode>
      <ExampleWithFunctor />
    </React.StrictMode>,
    element,
  )
| None => Js.Exn.raiseError("Root element not found")
}
