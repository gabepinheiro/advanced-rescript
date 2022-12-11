open LocalStorage

@react.component
let make = () => {
  let (state, setState) = React.useState(_ => None)

  React.useEffect0(() => {
    setState(_ => Some(
      localStorage
      ->getItem(~key="date")
      ->Js.Null.toOption
      ->Belt.Option.mapWithDefault(Js.Date.make(), d => d->Js.Float.fromString->Js.Date.fromFloat),
    ))
    None
  })

  let updateDate = _ => {
    let date = Js.Date.now()
    localStorage->setItem(~key="date", ~value=date->Js.Float.toString)
    setState(_ => Some(date->Js.Date.fromFloat))
  }

  <div className="main-container">
    <p>
      {`The last saved date is: `->React.string}
      {switch state {
      | Some(date) =>
        `${date->Js.Date.toLocaleDateString} ${date->Js.Date.toLocaleTimeString}`->React.string
      | None => React.null
      }}
    </p>
    <button onClick=updateDate> {`Update date`->React.string} </button>
  </div>
}
