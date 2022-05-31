import { config, library, dom } from "@fortawesome/fontawesome-svg-core";
import { faEnvelopeOpenText } from "@fortawesome/free-solid-svg-icons/faEnvelopeOpenText";
import { faEnvelope } from "@fortawesome/free-solid-svg-icons/faEnvelope";
import { faBold } from "@fortawesome/free-solid-svg-icons/faBold";
import { faItalic } from "@fortawesome/free-solid-svg-icons/faItalic";
import { faHeading } from "@fortawesome/free-solid-svg-icons/faHeading";
import { faQuoteLeft } from "@fortawesome/free-solid-svg-icons/faQuoteLeft";
import { faListUl } from "@fortawesome/free-solid-svg-icons/faListUl";
import { faListOl } from "@fortawesome/free-solid-svg-icons/faListOl";
import { faLink } from "@fortawesome/free-solid-svg-icons/faLink";
import { faImage } from "@fortawesome/free-solid-svg-icons/faImage";
import { faEye } from "@fortawesome/free-solid-svg-icons/faEye";
import { faColumns } from "@fortawesome/free-solid-svg-icons/faColumns";
import { faArrowsAlt } from "@fortawesome/free-solid-svg-icons/faArrowsAlt";
import { faQuestionCircle } from "@fortawesome/free-solid-svg-icons/faQuestionCircle";
import { faUserGroup} from "@fortawesome/free-solid-svg-icons/faUserGroup";
import { faBullhorn } from "@fortawesome/free-solid-svg-icons/faBullhorn";
import { faClipboardList } from "@fortawesome/free-solid-svg-icons/faClipboardList";

config.mutateApproach = "sync";

library.add(
  faEnvelopeOpenText,
  faEnvelope,
  faBold,
  faItalic,
  faHeading,
  faQuoteLeft,
  faListUl,
  faListOl,
  faLink,
  faImage,
  faEye,
  faColumns,
  faArrowsAlt,
  faQuestionCircle,
  faUserGroup,
  faBullhorn,
  faClipboardList,
);
dom.watch();
