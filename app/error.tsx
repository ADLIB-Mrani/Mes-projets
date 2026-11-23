"use client";
export default function ErrorPage({reset}:{reset:()=>void}){return <section className="container page-section empty-state"><h1>Une interruption passagère.</h1><p>Le contenu n’a pas pu être chargé. Vous pouvez réessayer dans un instant.</p><button className="button primary" onClick={reset}>Réessayer</button></section>}
