import { useEffect, useRef, type ReactNode } from "react";

export const GITHUB = "https://github.com/phantomknight287/aero";

/** Phone frame drawn in CSS so screenshots stay crisp at any size. */
export function Phone({
  src,
  alt,
  className = "",
  eager = false,
}: {
  src: string;
  alt: string;
  className?: string;
  eager?: boolean;
}) {
  // Radii and bezel in cqw (percent of the phone's width), so the frame
  // keeps its proportions from a 90 px thumbnail to a 280 px hero.
  return (
    <div className={`@container ${className}`}>
      <div className="rounded-[16cqw] bg-black p-[2.8cqw] shadow-[0_30px_60px_-20px_rgba(0,0,0,0.35)] ring-1 ring-black/10 dark:ring-white/15">
        <div className="relative overflow-hidden rounded-[13.4cqw] bg-panel">
          <img
            src={src}
            alt={alt}
            loading={eager ? "eager" : "lazy"}
            className="block aspect-[3/7] w-full object-cover object-top"
          />
          {/* punch-hole camera */}
          <span className="absolute left-1/2 top-[1.1%] h-[2.4%] w-[5.4%] -translate-x-1/2 rounded-full bg-black" />
        </div>
      </div>
    </div>
  );
}

/** Round watch frame. Takes a screenshot via `src`, or any drawn face as children. */
export function Watch({
  src,
  alt = "",
  className = "",
  children,
}: {
  src?: string;
  alt?: string;
  className?: string;
  children?: ReactNode;
}) {
  return (
    <div className={`@container ${className}`}>
      <div className="aspect-square rounded-full bg-[#2b2b2b] p-[4cqw] shadow-[0_30px_60px_-20px_rgba(0,0,0,0.45)] ring-1 ring-black/20">
        <div className="h-full w-full overflow-hidden rounded-full bg-black">
          {src ? (
            <img src={src} alt={alt} loading="lazy" className="block h-full w-full" />
          ) : (
            children
          )}
        </div>
      </div>
    </div>
  );
}

/** Fades content up as it enters the viewport, once. */
export function Reveal({
  children,
  className = "",
  delay = 0,
}: {
  children: ReactNode;
  className?: string;
  delay?: number;
}) {
  const ref = useRef<HTMLDivElement>(null);
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const io = new IntersectionObserver(
      ([e]) => {
        if (e.isIntersecting) {
          el.classList.add("in");
          io.disconnect();
        }
      },
      { rootMargin: "0px 0px -10% 0px" },
    );
    io.observe(el);
    return () => io.disconnect();
  }, []);
  return (
    <div
      ref={ref}
      className={`reveal ${className}`}
      style={{ transitionDelay: `${delay}ms` }}
    >
      {children}
    </div>
  );
}

export function Chip({ children }: { children: ReactNode }) {
  return (
    <span className="inline-flex items-center rounded-full bg-panel px-3 py-1 text-sm text-ink-soft">
      {children}
    </span>
  );
}

export function SectionTitle({
  kicker,
  title,
  children,
}: {
  kicker: string;
  title: ReactNode;
  children?: ReactNode;
}) {
  return (
    <div className="max-w-2xl">
      <p className="text-xs font-semibold uppercase tracking-[0.14em] text-muted">
        {kicker}
      </p>
      <h2 className="mt-3 font-display text-4xl tracking-tight sm:text-5xl">
        {title}
      </h2>
      {children && (
        <p className="mt-4 text-lg leading-relaxed text-muted">{children}</p>
      )}
    </div>
  );
}

export function GithubMark({ className = "h-5 w-5" }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" aria-hidden className={className} fill="currentColor">
      <path d="M12 .5C5.65.5.5 5.65.5 12c0 5.08 3.29 9.39 7.86 10.91.58.11.79-.25.79-.56v-2c-3.2.7-3.87-1.37-3.87-1.37-.52-1.33-1.28-1.68-1.28-1.68-1.05-.72.08-.7.08-.7 1.16.08 1.77 1.19 1.77 1.19 1.03 1.77 2.7 1.26 3.36.96.1-.75.4-1.26.73-1.55-2.55-.29-5.24-1.28-5.24-5.7 0-1.26.45-2.29 1.19-3.1-.12-.29-.52-1.46.11-3.05 0 0 .97-.31 3.18 1.18a11 11 0 0 1 5.79 0c2.2-1.49 3.17-1.18 3.17-1.18.63 1.59.23 2.76.11 3.05.74.81 1.19 1.84 1.19 3.1 0 4.43-2.7 5.4-5.26 5.69.41.36.78 1.06.78 2.14v3.17c0 .31.21.68.8.56A11.5 11.5 0 0 0 23.5 12C23.5 5.65 18.35.5 12 .5Z" />
    </svg>
  );
}
