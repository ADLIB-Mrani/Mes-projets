import Link from "next/link";
export default function NotFound(){return <section className="container page-section empty-state"><span className="eyebrow">PAGE INTROUVABLE</span><h1>Ce chemin reste à explorer.</h1><p>La page ou le projet demandé n’est pas disponible.</p><Link className="button primary" href="/projets">Retrouver les projets</Link></section>}
